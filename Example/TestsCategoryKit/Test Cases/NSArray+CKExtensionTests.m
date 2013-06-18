//
//  NSArray+CKExtensionTests.m
//  CategoryKit
//
//  Created by Lisovoy Ivan on 6/18/13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <GHUnitIOS/GHUnit.h>
#import "NSArray+CKExtension.h"

@interface NSArray_CKExtensionTests : GHTestCase

@end

@implementation NSArray_CKExtensionTests

// -----------------------------------------------------------------------------

- (void) testFirstObject {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    GHAssertEquals([array objectAtIndex:0], [array firstObject], nil);
}

// -----------------------------------------------------------------------------

- (void)testReversed {
	NSArray *array = [[NSArray arrayWithObjects:@"1", @"2", @"3", nil] reversedArray];
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
	GHAssertEqualObjects(array, expected, nil);
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRange0Length {
	NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
	NSArray *subarray1 = [array subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected1 = [NSArray array];
	GHAssertEqualObjects(subarray1, expected1, nil);
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeEqual {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	NSArray *subarray2 = [array subarrayWithRange:NSMakeRange(0, 3)];
    
	GHAssertEqualObjects(subarray2, array, nil);
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeNormal {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
	NSArray *subarray3 = [array subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected3 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GHAssertEqualObjects(subarray3, expected3, nil);
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeOverflow {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];

	NSArray *subarray4 = [array subarrayWithRange:NSMakeRange(1, 4)];
	NSArray *expected4 = [NSArray arrayWithObjects:@"2", @"3", nil];
	GHAssertEqualObjects(subarray4, expected4, nil);
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeLocationOverflow {
    NSArray *array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
    
    NSArray *subarray5 = [array subarrayWithRange:NSMakeRange(3, 0)];
	GHAssertTrue([subarray5 count] == 0, nil);
}

// -----------------------------------------------------------------------------

@end
