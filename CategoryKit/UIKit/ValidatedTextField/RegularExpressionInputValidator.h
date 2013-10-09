//
//  RegularExpressionInputValidator.h
//  PropConnect
//
//  Created by Denis Kotenko on 08.03.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "InputValidator.h"


@interface RegularExpressionInputValidator : InputValidator {
    
    NSString *regularExpression;
    NSString *reason;
    NSInteger errorCode;
    
}

@end
