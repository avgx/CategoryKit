//
//  NSString+Reversed.m
//  AFlip
//
//  Created by Lisovoy Ivan on 2/9/13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSString+CKReversed.h"

@implementation NSString (CKReversed)

// -------------------------------------------------------------------------------

- (NSString *) reversed {
    NSMutableString *reversed = [NSMutableString stringWithCapacity:self.length];
    
    @try {
        [self enumerateSubstringsInRange:NSMakeRange(0, self.length)
            options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                [reversed appendString:substring];
            }];
        
        return reversed;
    }
    @catch (NSException *exception) {
        return self;
    }
}

// -------------------------------------------------------------------------------

@end
