//
//  InputValidator.h
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>


static NSString *const InputValidationErrorDomain         = @"InputValidationErrorDomain";
static NSInteger const InputValidationNumericErrorCode    = 1001;
static NSInteger const InputValidationAlphabetErrorCode   = 1002;
static NSInteger const InputValidationEmailErrorCode      = 1003;
static NSInteger const InputValidationRequiredErrorCode   = 1004;


@interface InputValidator : NSObject {
    
}

+ (InputValidator *) numericValidator;
+ (InputValidator *) alphaValidator;
+ (InputValidator *) emailValidator;
+ (InputValidator *) requiredValidator;

/**
 * A stub for any actual validation strategy.
 *
 * @param input UITextField for validation
 * @param error NSError object
 * @return YES if validation success, otherwise NO
 */
- (BOOL) validateInput:(UITextField *) input error:(NSError **) error;

@end
