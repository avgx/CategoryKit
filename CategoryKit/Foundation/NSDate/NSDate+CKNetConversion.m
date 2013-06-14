//
//  NSDate+netConversion.m
//  RitzPix-Phoenix
//
//  Created by yaroslav-imac on 12/21/12.
//  Copyright (c) 2012 Anton. All rights reserved.
//

#import "NSDate+CKNetConversion.h"

@implementation NSDate (CKNetConversion)

// -------------------------------------------------------------------------------

+ (NSDate *)dateFromDotNet:(NSString* )stringDate {
    static NSDateFormatter *parser = nil;
    
    if (parser == nil) {
        parser = [[NSDateFormatter alloc] init];
        [parser setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [parser setFormatterBehavior:NSDateFormatterBehavior10_4];
        [parser setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
        [parser setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    }
    
    NSDate *returnValue = [parser dateFromString:stringDate];
    return returnValue;
}

// -------------------------------------------------------------------------------

- (NSString *)dateToDotNet {
    double timeSince1970=[self timeIntervalSince1970];
    NSInteger offset = [[NSTimeZone defaultTimeZone] secondsFromGMT];
    offset=offset/3600;
    double nowMillis = 1000.0 * (timeSince1970);
    NSString *dotNetDate=[NSString stringWithFormat:@"/Date(%.0f%+03d00)/",nowMillis,offset];
    
    return dotNetDate;
}

// -------------------------------------------------------------------------------

@end
