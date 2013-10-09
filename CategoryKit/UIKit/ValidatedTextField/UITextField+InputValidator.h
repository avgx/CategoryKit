//
//  UITextField+InputValidator.h
//  CategoryKit
//
//  Created by Denis Kotenko on 09.10.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RequiredInputValidator.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"
#import "EmailInputValidator.h"


extern NSString *const UITextFieldInvalidDependencyException;


@interface UITextField (InputValidator)

- (BOOL) containsValidator:(InputValidator *) aValidator;

- (void) addValidator:(InputValidator *) aValidator;
- (void) removeValidator:(InputValidator *) aValidator;
- (void) removeAllValidators;
- (NSArray *) validators;

- (void) validateWithDependencies;
- (BOOL) validate;

- (void) addDependency:(UITextField *) textField;
- (void) removeDependency:(UITextField *) textField;
- (void) removeAllDependencies;
- (NSMutableArray *) dependencies;

- (void) addDependent:(UITextField *) textField;
- (void) removeDependent:(UITextField *) textField;
- (void) removeAllDependents;
- (NSArray *) dependents;

@end
