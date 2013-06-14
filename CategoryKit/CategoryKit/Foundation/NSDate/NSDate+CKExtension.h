//
//  NSDate+CKExtension.h
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kDateFormatShortMonthFullYearTime;

#define CKTimeIntervalMinute (60)
#define CKTimeIntervalHour (CKTimeIntervalMinute * 60)
#define CKTimeIntervalDay (CKTimeIntervalHour * 24)
#define CKTimeIntervalWeek (CKTimeIntervalDay * 7)
#define CKTimeIntervalYear (CKTimeIntervalDay * 365.242199)
#define CKTimeIntervalMax (DBL_MAX)

@interface NSDate (CKExtension)

/*!
 Return new date by adding (or subtracting) days from date.
 
 @param days +/- N days
 @result Date with days added or subtracted
 */
- (NSDate *) addDays:(NSInteger)days;

/*!
 Get normalized date (hours/minutes/seconds) set to 0; Begining of day.
 
 @result Beginning day of current date
 */
- (NSDate *)beginningOfDay;

/*!
 Yesterday (beginning of day).
 
 @result Previous day (beginning)
 */
+ (NSDate *)yesterday;

/*!
 Tomorrow (beginning of day).
 
 @result Next day (beginning)
 */
+ (NSDate *)tomorrow;

/*!
 Check if date is tomorrow.
 
 @result YES if tomorrow
 */
- (BOOL)isTomorrow;

/*!
 Check if date was or is today.
 
 @result YES if today
 */
- (BOOL)isToday;

/*!
 Check if date was yesterday.
 
 @result YES if yesterday
 */
- (BOOL)wasYesterday;

/*!
 Get weekday symbol, with special naming for 'Yesterday', 'Today' and 'Tomorrow'.
 
 @param formatter Date formatter, if nil will return nil if not yesterday, today or tomorrow
 @result 'Yesterday', 'Today' and 'Tomorrow' or weekday symbol for specified formatter
 */
- (NSString *)weekday:(NSDateFormatter *)formatter;

/*!
 Format date.
 
 @param format Format
 @param useWeekday If YES, will prepend weekday (or 'Today', 'Tomorrow', 'Yesterday')
 */
- (NSString *)format:(NSString *)format useWeekday:(BOOL)useWeekday;

/*!
 Create date from date and add days and/or normalize.
 
 @param date The date to start at
 @param addDay If not 0, will add these number of days to the date.
 @param normalize If YES will set hours, minutes, seconds to 0
 */
+ (NSDate *)dateFromDate:(NSDate *)date addDay:(NSInteger)addDay normalize:(BOOL)normalize;

/*!
 Create date with day, month, year, and add days, months or years.
 
 To use the current day, month or year, specify 0 for that value.
 
 For example, the use Jan 1, 30 years ago:
 
 [NSDate dateWithDay:1 month:1 year:0 addDay:0 addMonth:0 addYear:-30 timeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
 
 @param day Day to set (if 0, uses current day)
 @param month Month to set (if 0, uses current month)
 @param year Year to set (if 0, uses current year)
 @param addDay Days to add
 @param addMonth Month to add
 @param addYear Year to add
 @param timeZone Time zone to use
 @result Date
 */
+ (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                    addDay:(NSInteger)addDay addMonth:(NSInteger)addMonth addYear:(NSInteger)addYear
                  timeZone:(NSTimeZone *)timeZone;

/*!
 Create date with day, month, year.
 
 To use the current day, month or year, specify 0 for that value.
 
 For example, the use Jan, 1 (current year):
 
 [NSDate dateWithDay:1 month:1 year:0 timeZone:nil];
 
 
 @param day Day to set (if 0, uses current day)
 @param month Month to set (if 0, uses current month)
 @param year Year to set (if 0, uses current year)
 @param timeZone Time zone
 @result Date
 */
+ (NSDate *)dateWithDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
                  timeZone:(NSTimeZone *)timeZone;

/*!
 Date components for date.
 
 @param flags Flags, e.g. NSMonthCalendarUnit, or NSMonthCalendarUnit | NSYearCalendarUnit
 @param timeZone Time zone
 @result Date components
 */
- (NSDateComponents *)dateComponentsFromFlags:(NSUInteger)flags timeZone:(NSTimeZone *)timeZone;

/*!
 Month symbols, same as standaloneMonthSymbols from NSDateFormatter.
 */
+ (NSArray *)monthSymbols;

/*!
 Day of date.
 
 @result Day
 */
- (NSInteger)day;

/*!
 Day of date.
 
 @param timeZone Time zone
 @result Day
 */
- (NSInteger)dayForTimeZone:(NSTimeZone *)timeZone;

/*!
 Month of date.
 
 @result Year
 */
- (NSInteger)month;

/*!
 Month of date.
 
 @param timeZone Time zone
 @result Month
 */
- (NSInteger)monthForTimeZone:(NSTimeZone *)timeZone;

/*!
 Year of date.
 @result Year
 */
- (NSInteger)year;

/*!
 Year of date.
 @param timeZone Time zone
 @result Year
 */
- (NSInteger)yearForTimeZone:(NSTimeZone *)timeZone;


/*!
 Time ago in words.
 For more info, especially on localization, see GHNSString+TimeInterval.h.
 
 These are the localized defaults, that you can override:
 
 LessThanAMinute = "less than a minute";
 LessThanXSeconds = "less than %d seconds";
 HalfMinute = "half a minute";
 1Minute = "1 minute";
 XMinutes = "%.0f minutes";
 About1Hour = "about 1 hour";
 AboutXHours = "about %.0f hours";
 1Day = "1 day";
 XDays = "%.0f days";
 About1Month = "about 1 month";
 XMonths = "%.0f months";
 About1Year = "about 1 year";
 OverXYears = "over %.0f years";
 
 
 @param includeSeconds If YES, will include seconds (30 seconds ago), otherwise will say something like 'Less than a minute'
 @result Time ago in words
 */
- (NSString *)timeAgo:(BOOL)includeSeconds;

/*!
 Time ago in abbreviated format.
 For more info, especially on localization, see GHNSString+TimeInterval.h.
 
 These are the localized defaults, that you can override:
 
 XSecondsAbbreviated = "%.0fs";
 XMinutesAbbreviated = "%.0fm";
 XHoursAbbreviated = "%.0fh";
 XDaysAbbreviated = "%.0fd";
 XMonthsAbbreviated = "%.0fmo";
 XYearsAbbreviated = "%.0fy";
 
 @result Time ago in abbreviated format
 */
- (NSString *)timeAgoAbbreviated;

/*!
 Milliseconds since 1970.
 
 @result Milliseconds since 1970 GMT.
 */
- (long long)millisSince1970;

/*!
 Milliseconds since 1970 (NSNumber).
 
 @result Milliseconds since 1970 GMT
 */
- (NSNumber *)millisNumberSince1970;

/*!
 Seconds since 1970.
 
 @result Seconds since 1970 GMT (rounded)
 */
- (long long)secondsSince1970;

/*!
 Seconds since 1970 (NSNumber).
 
 @result Seconds since 1970 GMT (rounded)
 */
- (NSNumber *)secondsNumberSince1970;



@end
