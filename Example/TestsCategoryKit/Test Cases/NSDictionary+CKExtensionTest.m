//
//  NSDictionary+CKExtension.m
//  CategoryKit
//
//  Created by Ivan Lisovoy on 19.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSDictionary+CKExtension.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>


@interface NSDictionary_CKExtensionTest : SenTestCase {
    NSDictionary *_sut;
}
 
@end

@implementation NSDictionary_CKExtensionTest

// -------------------------------------------------------------------------------

- (void) setUp {
    [super setUp];
    _sut = @{
        @"strKey"     : @"1",
        @"YESBoolKey" : @(YES),
        @"NOBoolKey"  : @(NO),
        @"floatKey"   : @(1.123),
        @"integerKey" : @(1)
    };
}

// -------------------------------------------------------------------------------

- (void) tearDown {
    _sut = nil;
    [super tearDown];
}

// -----------------------------------------------------------------------------

- (void)testBoolValue {
    assertThatBool([_sut boolForKey:@"YESBoolKey"], equalToBool(YES));
    assertThatBool([_sut boolForKey:@"NOBoolKey"], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void)testIntegerValue {
    assertThatInteger([_sut integerForKey:@"integerKey"], equalToInteger(1));
    assertThatInteger([_sut integerForKey:@"intKey"], equalToInteger(0));
}

// -----------------------------------------------------------------------------

- (void)testFloatValue {
    assertThatFloat([_sut floatForKey:@"floatKey"], equalToFloat(1.123));
    assertThatFloat([_sut floatForKey:@"flKey"], equalToFloat(0.0));
}

// -----------------------------------------------------------------------------

- (void)testNSNumberValue {
    assertThat([_sut numberForKey:@"integerKey"], instanceOf([NSNumber class]));
    assertThat([_sut numberForKey:@"integerKey"], equalTo(@(1)));
}

// -----------------------------------------------------------------------------

- (void)testHasAllKeysYES {
    BOOL result = [_sut hasAllKeys:@"strKey", @"floatKey", nil];
    assertThatBool(result, equalToBool(YES));
}

// -----------------------------------------------------------------------------

- (void)testHasAllKeyNO {
    BOOL result = [_sut hasAllKeys:@"strKey", @"fuckTheSystemKey", nil];
    assertThatBool(result, equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void)testSubsetWithKeys {
    NSDictionary *subset = [_sut dictionarySubsetWithKeys:@[@"strKey", @"YESBoolKey"]];
    
    assertThat(subset, hasEntry(@"strKey", @"1"));
    assertThat(subset, hasEntry(@"YESBoolKey", equalToBool(YES)));
}

// -----------------------------------------------------------------------------

@end
