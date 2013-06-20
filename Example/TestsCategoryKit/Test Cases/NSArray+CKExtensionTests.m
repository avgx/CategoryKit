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
    NSArray *_sut;
}
@end

@implementation NSArray_CKExtensionTests

// -------------------------------------------------------------------------------

- (void) setUp {
    [super setUp];
    _sut = [NSArray arrayWithObjects:@"1", @"2", @"3", nil];
}

// -------------------------------------------------------------------------------

- (void) tearDown {
    _sut = nil;
    [super tearDown];
}

// -----------------------------------------------------------------------------

- (void) testFirstObject {
    assertThat([_sut objectAtIndex:0], is([_sut firstObject]));
}

// -------------------------------------------------------------------------------

- (void) testFirstObjectOfEmptyArrayShouldBeNil {
    assertThat([[NSArray array] firstObject], nilValue());
}

// -------------------------------------------------------------------------------

- (void) testIsAllObjectsConformsToProtocolShouldReturnYES {
    assertThatBool([_sut isAllObjectsConformsToProtocol:@protocol(NSCopying)], equalToBool(YES));
}

// -------------------------------------------------------------------------------

- (void) testIsAllObjectConformsToProtocolShouldReturnNO {
    assertThatBool([_sut isAllObjectsConformsToProtocol:@protocol(UIScrollViewDelegate)], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void) testReversed {
	NSArray *expected = [NSArray arrayWithObjects:@"3", @"2", @"1", nil];
    assertThat([_sut reversedArray], is(expected));
}

// -----------------------------------------------------------------------------

- (void) testSubarrayWithRange0Length {
	NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(0, 0)];
	NSArray *expected = [NSArray array];
    assertThat(subarray, is(expected));
}

// -----------------------------------------------------------------------------

- (void) testSubarrayWithRangeEqual {
	NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(0, 3)];
    assertThat(subarray, is(_sut));
}

// -----------------------------------------------------------------------------

- (void) testSubarrayWithRangeNormal {
	NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(1, 2)];
	NSArray *expected = [NSArray arrayWithObjects:@"2", @"3", nil];
    
    assertThat(subarray, is(expected));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithRangeLocationGreaterThanOriginalArrayCountShouldReturnEmptyArray {
    NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(4, 1)];
    assertThat(subarray, is([NSArray array]));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithRangeGreaterThanOriginalArrayCountShouldReturnOriginalArray {
    NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(0, 4)];
    assertThat(subarray, is(_sut));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithRangeEqualToOriginalArrayCountShouldReturnOriginalArray {
    NSArray *subarray = [_sut subarrayWithRange:NSMakeRange(0, 3)];
    assertThat(subarray, is(_sut));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayToIndex0ShouldReturnEmptyArray {
    NSArray *subarray = [_sut subarrayToIndex:0];
    assertThat(subarray, is([NSArray array]));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayToIndex1ShouldReturnArrayWithFirstObjectOfOriginalArray {
    NSArray *subarray = [_sut subarrayToIndex:1];
    NSArray *expected = @[@"1"];
    assertThat(subarray, is(expected));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayToIndexGreaterThenOriginalArrayCountShouldReturnOriginalArray {
    NSArray *subarray = [_sut subarrayToIndex:4];
    assertThat(subarray, is(_sut));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayToIndexEqualToOriginalArrayCountShouldReturnOriginalArray {
    NSArray *subarray = [_sut subarrayToIndex:3];
    assertThat(subarray, is(_sut));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayFromIndex0ShouldReturnOriginalArray {
    NSArray *subarray = [_sut subarrayFromIndex:0];
    assertThat(subarray, is(_sut));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayFromIndexGreatherThenOriginalArrayCountShouldReturnEmptyArray {
    NSArray *subarray = [_sut subarrayFromIndex:4];
    assertThat(subarray, is([NSArray array]));
}
               
// -------------------------------------------------------------------------------

- (void) testSubarrayFromIndexEqualToOriginalArrayCountShouldReturnEmptyArray {
    NSArray *subarray = [_sut subarrayFromIndex:3];
    assertThat(subarray, is([NSArray array]));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithPredicate {
    NSArray *subarray = [_sut filteredArrayUsingPredicateWithFormat:@"SELF == %@", @"2"];
    NSArray *expected = @[@"2"];
    
    assertThat(subarray, is(expected));
}

// -------------------------------------------------------------------------------

- (void) testSubarrayWithNilPredicate {
    NSArray *subarray = [_sut filteredArrayUsingPredicateWithFormat:nil];
    
    assertThat(subarray, nilValue());
}

// -------------------------------------------------------------------------------

@end
