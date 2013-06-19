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


@interface NSArray_CKExtensionTests : SenTestCase {
    NSArray *_array;
}
@end

@implementation NSArray_CKExtensionTests

// -------------------------------------------------------------------------------

- (void)setUp {
    [super setUp];
    _array = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
}

// -----------------------------------------------------------------------------

- (void)testFirstObject {
    assertThat([_array objectAtIndex:0], is([_array firstObject]));
}

// -------------------------------------------------------------------------------

- (void)testIsAllObjectsConformsToProtocolShouldReturnYES {
    assertThatBool([_array isAllObjectsConformsToProtocol:@protocol(NSCopying)], equalToBool(YES));
}

// -------------------------------------------------------------------------------

- (void)testIsAllObjectConformsToProtocolShouldReturnNO {
    assertThatBool([_array isAllObjectsConformsToProtocol:@protocol(UIScrollViewDelegate)], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void)testReversed {
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
    assertThat([_array reversedArray], is(expected));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRange0Length {
	NSArray *subarray = [_array subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected = [NSArray array];
    assertThat(subarray, is(expected));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeEqual {
	NSArray *subarray = [_array subarrayWithRange:NSMakeRange(0, 3)];
    
    assertThat(subarray, is(_array));
}

// -----------------------------------------------------------------------------

- (void)testSubarrayWithRangeNormal {
	NSArray *subarray = [_array subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected = [NSArray arrayWithObjects:@"2", @"3", nil];
    
    assertThat(subarray, is(expected));
}

// -----------------------------------------------------------------------------

- (void) testSubarrayWithPredicate {
    NSArray *array = @[@(1), @(2), @(3)];
    NSArray *subarray4 = [array filteredArrayUsingPredicateWithFormat:@"SELF == %@", @(2)];
    NSArray *expected4 = @[@(2)];
    
    assertThat(subarray4, is(expected4));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithNilPredicate {
    NSArray *array = @[@(1), @(2), @(3)];
    NSArray *subarray4 = [array filteredArrayUsingPredicateWithFormat:nil];
    
    assertThat(subarray4, nilValue());
}

// -------------------------------------------------------------------------------

@end
