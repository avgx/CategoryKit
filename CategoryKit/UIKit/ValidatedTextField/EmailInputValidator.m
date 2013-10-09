//
//  EmailInputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "EmailInputValidator.h"


@implementation EmailInputValidator

// -------------------------------------------------------------------------------

- (id) init {
    self = [super init];
    if (self) {
        regularExpression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        reason = NSLocalizedString(@"Email is incorrect", @"Validator reason (Alert)");
        errorCode = InputValidationEmailErrorCode;
    }
    
    return self;
}

// -------------------------------------------------------------------------------

@end
