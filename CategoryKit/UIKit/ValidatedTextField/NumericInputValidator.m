//
//  NumericInputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "NumericInputValidator.h"


@implementation NumericInputValidator

// -------------------------------------------------------------------------------

- (id) init {
    self = [super init];
    if (self) {
        regularExpression = @"^[0-9]*$";
        reason = NSLocalizedString(@"The input can contain only numerical values", @"Validator reason (Alert)");
        errorCode = InputValidationNumericErrorCode;
    }
    
    return self;
}

// -------------------------------------------------------------------------------

@end
