//
//  EmptyInputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "RequiredInputValidator.h"


@implementation RequiredInputValidator

// -------------------------------------------------------------------------------

- (BOOL) validateInput:(UITextField *) input error:(NSError **) error {
    NSString *text = [[input text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([text length] == 0) {
        NSString *reason = NSLocalizedString(@"The text field can't not be empty.", @"Validator reason (Alert)");
        if (error != nil) {
            *error = [self errorWithReason:reason code:InputValidationRequiredErrorCode];
        }
        return NO;
    }
    return YES;
}

// -------------------------------------------------------------------------------

@end
