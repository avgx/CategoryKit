//
//  InputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "InputValidator.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"
#import "EmailInputValidator.h"
#import "RequiredInputValidator.h"


@implementation InputValidator

// -------------------------------------------------------------------------------

+ (InputValidator *) numericValidator {
    return [[NumericInputValidator alloc] init];
}

// -------------------------------------------------------------------------------

+ (InputValidator *) alphaValidator {
    return [[AlphaInputValidator alloc] init];
}

// -------------------------------------------------------------------------------

+ (InputValidator *) emailValidator {
    return [[EmailInputValidator alloc] init];
}

// -------------------------------------------------------------------------------


+ (InputValidator *) requiredValidator {
    return [[RequiredInputValidator alloc] init];
}

// -------------------------------------------------------------------------------

- (NSError *) errorWithReason:(NSString *) aReason code:(NSInteger) code {
    NSString *description = NSLocalizedString(@"Input Validation Failed", @"Input Validation Failed");
    NSArray *objArray = [NSArray arrayWithObjects:description, aReason, nil]; 
    NSArray *keyArray = [NSArray arrayWithObjects:
        NSLocalizedDescriptionKey, NSLocalizedFailureReasonErrorKey, nil];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjects:objArray forKeys:keyArray];
    NSError *error = [NSError errorWithDomain:InputValidationErrorDomain code:code userInfo:userInfo];
    return error;
}

// -------------------------------------------------------------------------------

- (BOOL) validateInput:(UITextField *) input error:(NSError **) error {
    if (error) {
        *error = nil; 
    }
    
    return NO;
}

// -------------------------------------------------------------------------------

@end
