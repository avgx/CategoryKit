//
//  UITextField+InputValidator.m
//  CategoryKit
//
//  Created by Denis Kotenko on 09.10.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "UITextField+InputValidator.h"

#import "NSObject+CKRuntimeHelper.h"


NSString *const UITextFieldInvalidDependencyException = @"UITextFieldInvalidDependencyException";


@implementation UITextField (InputValidator)

// -------------------------------------------------------------------------------

- (void) addDependency:(UITextField *) textField {
    if ([self _dependencies] == nil) {
        [self _setDependencies:[NSMutableArray array]];
    }
    
    if ([[self _dependencies] containsObject:textField]) {
        return;
    }
    
    if ([[textField dependencies] containsObject:self]) {
        @throw [NSException exceptionWithName:UITextFieldInvalidDependencyException reason:nil userInfo:nil];
    }
    
    [[self _dependencies] addObject:textField];
    [textField addDependent:self];
}

// -------------------------------------------------------------------------------

- (void) removeDependency:(UITextField *) textField {
    [[self _dependencies] removeObject:textField];
    [textField removeDependent:self];
}

// -------------------------------------------------------------------------------

- (void) removeAllDependencies {
    [[self _dependencies] makeObjectsPerformSelector:@selector(removeDependent:) withObject:self];
    [[self _dependencies] removeAllObjects];
}

// -------------------------------------------------------------------------------

- (NSArray *) dependencies {
    if ([self _dependencies] == nil) {
        return nil;
    }
    
    NSMutableArray *allDependencies = [NSMutableArray array];
    for (UITextField *textField in [self _dependencies]) {
        [allDependencies addObjectsFromArray:[textField dependencies]];
    }
    [allDependencies addObjectsFromArray:[self _dependencies]];
    return allDependencies;
}

// -------------------------------------------------------------------------------

- (NSMutableArray *) _dependencies {
    return [self associatedObjectForKey:@"_dependencies"];
}

// -------------------------------------------------------------------------------

- (void) _setDependencies:(NSMutableArray *) dependencies {
    [self setAssociatedObject:dependencies forKey:@"_dependencies"];
}

// -------------------------------------------------------------------------------

- (void) addDependent:(UITextField *) textField {
    if ([self _dependents] == nil) {
        [self _setDependents:[NSMutableArray array]];
    }
    
    if ([[self _dependents] containsObject:textField]) {
        return;
    }
    [[self _dependents] addObject:textField];
}

// -------------------------------------------------------------------------------

- (void) removeDependent:(UITextField *) textField {
    [[self _dependents] removeObject:textField];
}

// -------------------------------------------------------------------------------

- (void) removeAllDependents {
    [[self _dependents] removeAllObjects];
}

// -------------------------------------------------------------------------------

- (NSArray *) dependents {
    return [NSArray arrayWithArray:[self _dependents]];
}

// -------------------------------------------------------------------------------

- (NSMutableArray *) _dependents {
    return [self associatedObjectForKey:@"_dependents"];
}

// -------------------------------------------------------------------------------

- (void) _setDependents:(NSMutableArray *) dependents {
    [self setAssociatedObject:dependents forKey:@"_dependents"];
}

// -------------------------------------------------------------------------------

- (void) addValidator:(InputValidator *) aValidator {
    if ([self _validators] == nil) {
        [self _setValidators:[NSMutableArray alloc]];
    }
    
    if ([self containsValidator:aValidator]) {
        return;
    }
    [[self _validators] addObject:aValidator];
}

// -------------------------------------------------------------------------------

- (BOOL) containsValidator:(InputValidator *) aValidator {
    return [[self _validators] containsObject:aValidator];
}

// -------------------------------------------------------------------------------

- (NSMutableArray *) _validators {
    return [self associatedObjectForKey:@"_validators"];
}

// -------------------------------------------------------------------------------

- (void) _setValidators:(NSMutableArray *) validators {
    [self setAssociatedObject:validators forKey:@"_validators"];
}

// -------------------------------------------------------------------------------

- (void) removeValidator:(InputValidator *) aValidator {
    [[self _validators] removeObject:aValidator];
}

// -------------------------------------------------------------------------------

- (void) removeAllValidators {
    [[self _validators] removeAllObjects];
}

// -------------------------------------------------------------------------------

- (NSArray *) validators {
    return [NSArray arrayWithArray:[self _validators]];
}

// -------------------------------------------------------------------------------

- (void) validateWithDependencies {
    NSArray *array = [self dependencies];
    BOOL isDependeciesValid = YES;
    
    for (UITextField *textField in array) {
        [textField validate];
        
        if (!textField.isValid) {
            isDependeciesValid = NO;
            [self setIsValid:NO];
            break;
        }
    }
    
    if (isDependeciesValid) {
        [self validate];
    }
}

// -------------------------------------------------------------------------------

- (BOOL) isValid {
    return [[self associatedObjectForKey:@"_isValid"] boolValue];
}

// -------------------------------------------------------------------------------

- (void) setIsValid:(BOOL) isValid {
    [self setAssociatedObject:@(isValid) forKey:@"_isValid"];
}

// -------------------------------------------------------------------------------

- (BOOL) validate {
    NSMutableArray *errors = [NSMutableArray array];
    [self setIsValid:YES];
    [self setErrorTitle:nil];
    [self setErrorMessage:nil];
    
    for (InputValidator *validator in [self _validators]) {
        NSError *error = nil;
        [self setIsValid:[validator validateInput:self error:&error]];
        
        if ([self isValid] == NO) {
            [errors addObject:error];
        }
    }
    
    if ([self isValid] == NO) {
        [self setErrorTitle:[[errors objectAtIndex:0] localizedDescription]];
        [self setErrorMessage:[NSMutableString string]];
        
        if ([self textFieldLabel] == nil) {
            [self setTextFieldLabel:NSLocalizedString(@"Text Field", nil)];
        }
        
        for (NSError *error in errors) {
            [[self errorMessage] appendFormat:@"%@ - %@\n", [self textFieldLabel], [error localizedFailureReason]];
        }
        [[self errorMessage] deleteCharactersInRange:NSMakeRange([[self errorMessage] length] - 1, 1)];
    }
    
    
    [self.delegate performSelector:@selector(textFieldDidValidated:) withObject:self];
    return [self isValid];
}

// -------------------------------------------------------------------------------

- (NSString *) textFieldLabel {
    return [self associatedObjectForKey:@"_textFieldLabel"];
}

// -------------------------------------------------------------------------------

- (void) setTextFieldLabel:(NSString *) textFieldLabel {
    [self setAssociatedObject:textFieldLabel forKey:@"_textFieldLabel"];
}

// -------------------------------------------------------------------------------

- (NSString *) errorTitle {
    return [self associatedObjectForKey:@"_errorTitle"];
}

// -------------------------------------------------------------------------------

- (void) setErrorTitle:(NSString *) errorTitle {
    [self setAssociatedObject:errorTitle forKey:@"_errorTitle"];
}

// -------------------------------------------------------------------------------

- (NSMutableString *) errorMessage {
    return [self associatedObjectForKey:@"_errorMessage"];
}

// -------------------------------------------------------------------------------

- (void) setErrorMessage:(NSMutableString *) errorMessage {
    [self setErrorMessage:errorMessage];
}

// -------------------------------------------------------------------------------

@end
