//
//  NSDate+CKExtensionTest.m
//  CategoryKit
//
//  Created by Ivan Lisovoy on 19.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSDate+CKExtension.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface NSDate_CKExtensionTest : SenTestCase

@end

@implementation NSDate_CKExtensionTest

// -----------------------------------------------------------------------------

- (void) testWasYesterdayYES {
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:-(60 * 60 * 24)];
    assertThatBool([date wasYesterday], equalToBool(YES));
}

// -----------------------------------------------------------------------------

- (void) testWasYesterDayNo {
    NSDate *date = [NSDate date];
    assertThatBool([date wasYesterday], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void) testIsTommorowYES {
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24)];
    assertThatBool([date isTomorrow], equalToBool(YES));
}

// -----------------------------------------------------------------------------

- (void) testIsTommorowNO {
    NSDate *date = [NSDate date];
    assertThatBool([date isTomorrow], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void) testIsTodayYES {
    NSDate *date = [NSDate date];
    assertThatBool([date isToday], equalToBool(YES));
}

// -----------------------------------------------------------------------------

- (void) testIsTodayNo {
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:(60 * 60 * 24)];
    assertThatBool([date isToday], equalToBool(NO));
}

// -----------------------------------------------------------------------------

@end
