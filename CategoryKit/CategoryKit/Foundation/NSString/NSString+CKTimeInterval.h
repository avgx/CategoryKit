//
//  NSString+CKTimeInterval.h
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CKTimeInterval)

/*!
 Time ago in words.
 
 For localized values see the localization keys below.
 This method calls localizedStringForTimeInterval with nil tableName and [NSBundle mainBundle] bundle.
 
 @param interval Interval in seconds
 @param includeSeconds If YES, will say 'less than N seconds', otherwise will show 'less than a minute'
 @result Time ago in words
 */
+ (NSString *)stringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds;

/*!
 Time ago in words (localized).
 
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
 
 @param interval Interval in seconds
 @param includeSeconds If YES, will say 'less than N seconds', otherwise will show 'less than a minute'
 @param tableName Table name for localized string
 @param bundle Bundle for localized string
 @result Time ago in words
 */
+ (NSString *)localizedStringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds tableName:(NSString *)tableName bundle:(NSBundle *)bundle;


/*!
 Time ago in abbreviated format.
 
 For localized values see the localization keys below.
 This method calls localizedStringForTimeInterval with nil tableName and [NSBundle mainBundle] bundle.
 
 @param interval Interval in seconds
 @result Time ago in abbreviated format
 */
+ (NSString *)abbreviatedStringForTimeInterval:(NSTimeInterval)interval;

/*!
 Time ago in words (abbreviated and localized).
 
 These are the localized defaults, that you can override:
 
 XSecondsAbbreviated = "%.0fs";
 XMinutesAbbreviated = "%.0fm";
 XHoursAbbreviated = "%.0fh";
 XDaysAbbreviated = "%.0fd";
 XMonthsAbbreviated = "%.0fmo";
 XYearsAbbreviated = "%.0fy";
 
 @param interval Interval in seconds
 @param tableName Table name for localized string
 @param bundle Bundle for localized string
 @result Time ago in abbreviated words
 */
+ (NSString *)localizedAbbreviatedStringForTimeInterval:(NSTimeInterval)interval tableName:(NSString *)tableName bundle:(NSBundle *)bundle;


@end
