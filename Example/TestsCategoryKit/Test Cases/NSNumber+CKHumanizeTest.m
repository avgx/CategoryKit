//
//  NSNumber+CKHumanizeTest.m
//  CategoryKit
//
//  Created by Ivan Lisovoy on 19.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSNumber+CKHumanize.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface NSNumber_CKHumanizeTest : SenTestCase

@end

@implementation NSNumber_CKHumanizeTest

// -----------------------------------------------------------------------------

- (void)testHumanizeToKB {
    NSNumber *size = @(1024 * 2);
    
    assertThat([size humanSize], equalTo(@"2 KB"));
}

// -----------------------------------------------------------------------------

- (void)testHumanizeToMB {
    NSNumber *size = @(1024 * 1024 * 5);
    
    assertThat([size humanSize], equalTo(@"5.0 MB"));
}

// -----------------------------------------------------------------------------

- (void)testHumanizeToGB {
	NSNumber *size = @(5028463290);
    
    assertThat([size humanSize], equalTo(@"4.68 GB"));
}

// -----------------------------------------------------------------------------

@end
