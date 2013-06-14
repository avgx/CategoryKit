//
//  UIScreen+IsRetina.m
//  PopPopIdea
//
//  Created by Denis Kotenko on 23.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UIScreen+CKIsRetina.h"


@implementation UIScreen (CKIsRetina)

// -------------------------------------------------------------------------------

- (BOOL) isRetina {
    return [[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [UIScreen mainScreen].scale == 2.0;
}

// -------------------------------------------------------------------------------

@end
