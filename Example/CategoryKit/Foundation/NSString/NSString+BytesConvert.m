//
//  NSString+BytesConvert.m
//  Yakimbi
//
//  Created by Lisovoy Ivan on 3/5/13.
//  Copyright (c) 2013 Yakimbi. All rights reserved.
//

#import "NSString+BytesConvert.h"

@implementation NSString (BytesConvert)

// -------------------------------------------------------------------------------

+ (id) convertedValue:(id)value {
    
    double convertedValue = [value doubleValue];
    int multiplyFactor = 0;
    
    NSArray *tokens = [NSArray arrayWithObjects:@"bytes",@"KB",@"MB",@"GB",@"TB",nil];
    
    while (convertedValue >= 1024) {
        convertedValue /= 1024;
        multiplyFactor++;
    }
    
    return [NSString stringWithFormat:@"%4.1f %@",convertedValue, [tokens objectAtIndex:multiplyFactor]];
}

// -------------------------------------------------------------------------------

@end
