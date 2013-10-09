//
//  AlphaInputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "AlphaInputValidator.h"


@implementation AlphaInputValidator

// -------------------------------------------------------------------------------

- (id) init {
    self = [super init];
    if (self) {
        regularExpression = @"^[a-zA-Z]*$";
        reason = NSLocalizedString(@"The input can contain only letters", @"Validator reason (Alert)");
        errorCode = InputValidationAlphabetErrorCode;
    }
    
    return self;
}

// -------------------------------------------------------------------------------

@end
