//
//  NSString+CKTimeInterval.m
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSString+CKTimeInterval.h"
#import <math.h>

@implementation NSString (CKTimeInterval)

#define CKIntervalLocalize(key, defaultValue) NSLocalizedStringWithDefaultValue(key, tableName, bundle, defaultValue, nil)

+ (NSString *)stringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds {
	return [self localizedStringForTimeInterval:interval includeSeconds:includeSeconds tableName:nil bundle:[NSBundle mainBundle]];
}

// -----------------------------------------------------------------------------

+ (NSString *)localizedStringForTimeInterval:(NSTimeInterval)interval includeSeconds:(BOOL)includeSeconds tableName:(NSString *)tableName bundle:(NSBundle *)bundle {
    NSTimeInterval intervalInSeconds = fabs(interval);
    double intervalInMinutes = round(intervalInSeconds/60.0);
    
    if (intervalInMinutes >= 0 && intervalInMinutes <= 1) {
        if (!includeSeconds) return intervalInMinutes <= 0 ? CKIntervalLocalize(@"LessThanAMinute", @"less than a minute") : CKIntervalLocalize(@"1Minute", @"1 minute");
        if (intervalInSeconds >= 0 && intervalInSeconds < 5) return [NSString stringWithFormat:CKIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 5];
        else if (intervalInSeconds >= 5 && intervalInSeconds < 10) return [NSString stringWithFormat:CKIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 10];
        else if (intervalInSeconds >= 10 && intervalInSeconds < 20) return [NSString stringWithFormat:CKIntervalLocalize(@"LessThanXSeconds", @"less than %d seconds"), 20];
        else if (intervalInSeconds >= 20 && intervalInSeconds < 40) return CKIntervalLocalize(@"HalfMinute", @"half a minute");
        else if (intervalInSeconds >= 40 && intervalInSeconds < 60) return CKIntervalLocalize(@"LessThanAMinute", @"less than a minute");
        else return CKIntervalLocalize(@"1Minute", @"1 minute");
    }
    else if (intervalInMinutes >= 2 && intervalInMinutes <= 44) return [NSString stringWithFormat:CKIntervalLocalize(@"XMinutes", @"%.0f minutes"), intervalInMinutes];
    else if (intervalInMinutes >= 45 && intervalInMinutes <= 89) return CKIntervalLocalize(@"About1Hour", @"about 1 hour");
    else if (intervalInMinutes >= 90 && intervalInMinutes <= 1439) return [NSString stringWithFormat:CKIntervalLocalize(@"AboutXHours", @"about %.0f hours"), round(intervalInMinutes/60.0)];
    else if (intervalInMinutes >= 1440 && intervalInMinutes <= 2879) return CKIntervalLocalize(@"1Day", @"1 day");
    else if (intervalInMinutes >= 2880 && intervalInMinutes <= 43199) return [NSString stringWithFormat:CKIntervalLocalize(@"XDays", @"%.0f days"), round(intervalInMinutes/1440.0)];
    else if (intervalInMinutes >= 43200 && intervalInMinutes <= 86399) return CKIntervalLocalize(@"About1Month", @"about 1 month");
    else if (intervalInMinutes >= 86400 && intervalInMinutes <= 525599) return [NSString stringWithFormat:CKIntervalLocalize(@"XMonths", @"%.0f months"), round(intervalInMinutes/43200.0)];
    else if (intervalInMinutes >= 525600 && intervalInMinutes <= 1051199) return CKIntervalLocalize(@"About1Year", @"about 1 year");
    else
        return [NSString stringWithFormat:CKIntervalLocalize(@"OverXYears", @"over %.0f years"), floor(intervalInMinutes/525600.0)];
}

// -----------------------------------------------------------------------------

+ (NSString *)abbreviatedStringForTimeInterval:(NSTimeInterval)interval {
    return [self localizedAbbreviatedStringForTimeInterval:interval tableName:nil bundle:[NSBundle mainBundle]];
}

// -----------------------------------------------------------------------------

+ (NSString *)localizedAbbreviatedStringForTimeInterval:(NSTimeInterval)interval tableName:(NSString *)tableName bundle:(NSBundle *)bundle {
    NSTimeInterval intervalInSeconds = fabs(interval);
    double intervalInMinutes = round(intervalInSeconds/60.0);
    
    if (intervalInSeconds < 60) return [NSString stringWithFormat:CKIntervalLocalize(@"XSecondsAbbreviated", @"%.0fs"), intervalInSeconds];
    else if (intervalInMinutes >= 1 && intervalInMinutes < 60) return [NSString stringWithFormat:CKIntervalLocalize(@"XMinutesAbbreviated", @"%.0fm"), intervalInMinutes];
    else if (intervalInMinutes >= 60 && intervalInMinutes < 1440) return [NSString stringWithFormat:CKIntervalLocalize(@"XHoursAbbreviated", @"%.0fh"), round(intervalInMinutes/60.0)];
    else if (intervalInMinutes >= 1440 && intervalInMinutes < 43200) return [NSString stringWithFormat:CKIntervalLocalize(@"XDaysAbbreviated", @"%.0fd"), round(intervalInMinutes/1440.0)];
    else if (intervalInMinutes >= 43200 && intervalInMinutes < 525600) return [NSString stringWithFormat:CKIntervalLocalize(@"XMonthsAbbreviated", @"%.0fmo"), round(intervalInMinutes/43200.0)];
    else
        return [NSString stringWithFormat:CKIntervalLocalize(@"XYearsAbbreviated", @"%.0fy"), floor(intervalInMinutes/525600.0)];
}

// -----------------------------------------------------------------------------

@end
