// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
