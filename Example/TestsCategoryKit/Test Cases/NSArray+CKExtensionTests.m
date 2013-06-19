//
//  CategoryKit - NSArray+CKExtensionTests.m
//  Copyright 2013 Ramotion. All rights reserved.
//
//  Created by: Denis Kotenko
//

    // Class under test
#import "NSArray+CKExtension.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>


@interface NSArray_CKExtensionTests : SenTestCase
@end

@implementation NSArray_CKExtensionTests

// -----------------------------------------------------------------------------

- (void)testFirstObject {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    assertThat([array objectAtIndex:0], is([array firstObject]));
}

// -----------------------------------------------------------------------------

- (void)testReversed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] reversedArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
    assertThat(array, is(expected));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRange0Length {
	NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
	NSArray *subarray1 = [array subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected1 = [NSArray array];
    assertThat(subarray1, is(expected1));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeEqual {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	NSArray *subarray2 = [array subarrayWithRange:NSMakeRange(0, 3)];
    
    assertThat(subarray2, is(array));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeNormal {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	NSArray *subarray3 = [array subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected3 = [NSArray arrayWithObjects:@"2", @"3", nil];
    
    assertThat(subarray3, is(expected3));
}

// -----------------------------------------------------------------------------

@end
