//
//  RegularExpressionInputValidator.m
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "RegularExpressionInputValidator.h"
#import "RequiredInputValidator.h"


@implementation RegularExpressionInputValidator

// -------------------------------------------------------------------------------

- (NSError *) error {
    return [self errorWithReason:reason code:errorCode];
}

// -------------------------------------------------------------------------------

- (BOOL) validateInput:(UITextField *) input error:(NSError **) error {
    NSRegularExpression *regex = [NSRegularExpression
        regularExpressionWithPattern:regularExpression 
        options:NSRegularExpressionAnchorsMatchLines error:error];
    
    if ([[input text] length] == 0) {
        if (error != nil) {
            NSString *theReason = NSLocalizedString(@"The text field can't not be empty.", @"Validator reason (Alert)");
            *error = [self errorWithReason:theReason code:InputValidationRequiredErrorCode];
        }
        return NO;
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:[input text]
        options:NSMatchingAnchored 
        range:NSMakeRange(0, [[input text] length])];
    
    // if there is not a single match 
    // then return an error and NO 
    if (numberOfMatches == 0) {
        if (error != nil) {
            *error = [self error];
        }
        
        return NO;
    }
    
    return YES;
}

// -------------------------------------------------------------------------------

@end
