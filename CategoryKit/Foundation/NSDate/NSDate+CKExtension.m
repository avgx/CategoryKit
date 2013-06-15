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

#import "NSDate+CKExtension.h"
#import "NSString+CKTimeInterval.h"

NSString *const kDateFormatShortMonthFullYearTime = @"LLL d, yyyy hh:mm a";

@implementation NSDate (CKExtension)

NSUInteger const kUnitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit | NSWeekdayCalendarUnit;

+ (NSDate *)_dateFromDate:(NSDate *)date day:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                      addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear
                   normalize:(BOOL)normalize timeZone:(NSTimeZone *)timeZone {
	NSCalendar *calendar = [NSCalendar currentCalendar];
    if (timeZone) {
        [calendar setTimeZone:timeZone];
    }
    NSDateComponents *comps = [calendar components:kUnitFlags fromDate:date];
    if (normalize) {
        [comps setHour:0];
        [comps setMinute:0];
        [comps setSecond:0];
    }
	if (day != 0) [comps setDay:day];
    if (month != 0) [comps setMonth:month];
    if (year != 0) [comps setYear:year];
    
    if (addDay != 0) [comps setDay:([comps day] + addDay)];
    if (addMonth != 0) [comps setMonth:([comps month] + addMonth)];
    if (addYear != 0) [comps setYear:([comps year] + addYear)];
    
	return [calendar dateFromComponents:comps];
}

// -----------------------------------------------------------------------------

+ (NSDate *)dateFromDate:(NSDate *)date addDay:(NSInteger)addDay normalize:(BOOL)normalize {
    return [self _dateFromDate:date day:0 month:0 year:0 addDay:addDay addMonth:0 addYear:0
                        normalize:normalize timeZone:nil];
}

// -----------------------------------------------------------------------------

+ (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                  timeZone:(NSTimeZone *)timeZone {
    return [self dateWithDay:day month:month year:year addDay:0 addMonth:0 addYear:0 timeZone:timeZone];
}

// -----------------------------------------------------------------------------

+ (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                    addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear
                  timeZone:(NSTimeZone *)timeZone {
    return [self _dateFromDate:[NSDate date] day:day month:month year:year addDay:addDay addMonth:addMonth addYear:addYear
                        normalize:YES timeZone:timeZone];
    
}

// -----------------------------------------------------------------------------

- (NSDateComponents *)dateComponentsFromFlags:(NSUInteger)flags timeZone:(NSTimeZone *)timeZone {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if (timeZone) {
        [calendar setTimeZone:timeZone];
    }
    return [calendar components:flags fromDate:self];
}

// -----------------------------------------------------------------------------

- (NSInteger)day {
    return [self dayForTimeZone:nil];
}

// -----------------------------------------------------------------------------

- (NSInteger)dayForTimeZone:(NSTimeZone *)timeZone {
    return [[self dateComponentsFromFlags:NSDayCalendarUnit timeZone:timeZone] day];
}

// -----------------------------------------------------------------------------

- (NSInteger)month {
    return [self monthForTimeZone:nil];
}

// -----------------------------------------------------------------------------

- (NSInteger)monthForTimeZone:(NSTimeZone *)timeZone {
    return [[self dateComponentsFromFlags:NSMonthCalendarUnit timeZone:timeZone] month];
}

// -----------------------------------------------------------------------------

- (NSInteger)year {
    return [self yearForTimeZone:nil];
}

// -----------------------------------------------------------------------------

- (NSInteger)yearForTimeZone:(NSTimeZone *)timeZone {
    return [[self dateComponentsFromFlags:NSYearCalendarUnit timeZone:timeZone] year];
}

// -----------------------------------------------------------------------------

+ (NSArray *)monthSymbols {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *monthSymbols = [dateFormatter standaloneMonthSymbols];
    return monthSymbols;
}

// -----------------------------------------------------------------------------

- (NSDate *)addDays:(NSInteger)days {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *comps = [calendar components:kUnitFlags fromDate:self];
	if (days != 0) [comps setDay:[comps day] + days];
	return [calendar dateFromComponents:comps];
}

// -----------------------------------------------------------------------------

- (NSDate *)beginningOfDay {
	return [NSDate dateFromDate:self addDay:0 normalize:YES];
}

// -----------------------------------------------------------------------------

+ (NSDate *)yesterday {
	return [NSDate dateFromDate:[NSDate date] addDay:-1 normalize:YES];
}

// -----------------------------------------------------------------------------

+ (NSDate *)tomorrow {
	return [NSDate dateFromDate:[NSDate date] addDay:1 normalize:YES];
}

// -----------------------------------------------------------------------------

- (BOOL)isTomorrow {
	return ([[self beginningOfDay] compare:[NSDate tomorrow]] == NSOrderedSame);
}

// -----------------------------------------------------------------------------

- (BOOL)isToday {
	return ([[self beginningOfDay] compare:[[NSDate date] beginningOfDay]] == NSOrderedSame);
}

// -----------------------------------------------------------------------------

- (BOOL)wasYesterday {
	return ([[self beginningOfDay] compare:[NSDate yesterday]] == NSOrderedSame);
}

// -----------------------------------------------------------------------------

- (NSString *)weekday:(NSDateFormatter *)formatter {
	if ([self isTomorrow]) return NSLocalizedString(@"Tomorrow", nil);
	else if ([self isToday]) return NSLocalizedString(@"Today", nil);
	else if ([self wasYesterday]) return NSLocalizedString(@"Yesterday", nil);
	
	if (!formatter) return nil;
	
	NSInteger weekday = [[[NSCalendar currentCalendar] components:kUnitFlags fromDate:self] weekday] - 1;
	return [[formatter weekdaySymbols] objectAtIndex:weekday];
}

// -----------------------------------------------------------------------------

- (NSString *)format:(NSString *)format useWeekday:(BOOL)useWeekday {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:format];
	NSString *formatted = [dateFormatter stringFromDate:self];
	if (useWeekday) {
		NSString *specialWeekday = [self weekday:dateFormatter];
        formatted = [NSString stringWithFormat:@"%@, %@", specialWeekday, formatted];
	}
	return formatted;
}

// -----------------------------------------------------------------------------

- (NSString *)timeAgo:(BOOL)includeSeconds {
	return [NSString stringForTimeInterval:[self timeIntervalSinceNow] includeSeconds:includeSeconds];
}

// -----------------------------------------------------------------------------

- (NSString *)timeAgoAbbreviated {
    return [NSString abbreviatedStringForTimeInterval:[self timeIntervalSinceNow]];
}

// -----------------------------------------------------------------------------

- (long long)millisSince1970 {
	NSTimeInterval secondsSince1970 = [self timeIntervalSince1970];
	return (long long)round(secondsSince1970 * 1000);
}

// -----------------------------------------------------------------------------

- (NSNumber *)millisNumberSince1970 {
	long long millis = [self millisSince1970];
	return [NSNumber numberWithLongLong:millis];
}

// -----------------------------------------------------------------------------

- (long long)secondsSince1970 {
	NSTimeInterval secondsSince1970 = [self timeIntervalSince1970];
	return (long long)round(secondsSince1970);
}

// -----------------------------------------------------------------------------

- (NSNumber *)secondsNumberSince1970 {
	long long seconds = [self secondsSince1970];
	return [NSNumber numberWithLongLong:seconds];
}

// -----------------------------------------------------------------------------

@end
