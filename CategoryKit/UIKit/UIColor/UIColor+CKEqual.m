//
//  UIColor+Equal.m
//  HU.GE
//
//  Created by Denis Kotenko on 20.07.12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "UIColor+CKEqual.h"
#import "UIColor+CKExpanded.h"

@implementation UIColor (CKEqual)

// -------------------------------------------------------------------------------

- (BOOL) isEqualToColor:(UIColor *) color {
    BOOL result = self.red == color.red && 
                  self.green == color.green && 
                  self.blue == color.blue && 
                  self.alpha == color.alpha;
    
    return result;
}

// -------------------------------------------------------------------------------

@end
