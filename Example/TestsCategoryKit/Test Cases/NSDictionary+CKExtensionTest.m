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
    NSDictionary *_dictionary;
}
 
@end

@implementation NSDictionary_CKExtensionTest

- (void) setUp {
    [super setUp];
    
    _dictionary = @{@"strKey" : @"1", @"YESBoolKey" : @(YES), @"NOBoolKey" : @(NO), @"floatKey" : @(1.123), @"integerKey" : @(1)};
}

// -----------------------------------------------------------------------------

- (void)testBoolValue {
    assertThatBool([_dictionary boolForKey:@"YESBoolKey"], equalToBool(YES));
    assertThatBool([_dictionary boolForKey:@"NOBoolKey"], equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void)testIntegerValue {
    assertThatInteger([_dictionary integerForKey:@"integerKey"], equalToInteger(1));
    assertThatInteger([_dictionary integerForKey:@"intKey"], equalToInteger(0));
}

// -----------------------------------------------------------------------------

- (void)testFloatValue {
    assertThatFloat([_dictionary floatForKey:@"floatKey"], equalToFloat(1.123));
    assertThatFloat([_dictionary floatForKey:@"flKey"], equalToFloat(0.0));
}

// -----------------------------------------------------------------------------

- (void)testNSNumberValue {
    assertThat([_dictionary numberForKey:@"integerKey"], instanceOf([NSNumber class]));
    assertThat([_dictionary numberForKey:@"integerKey"], equalTo(@(1)));
}

// -----------------------------------------------------------------------------

- (void)testHasAllKeysYES {
    BOOL result = [_dictionary hasAllKeys:@"strKey", @"floatKey", nil];
    assertThatBool(result, equalToBool(YES));
}

// -----------------------------------------------------------------------------

- (void)testHasAllKeyNO {
    BOOL result = [_dictionary hasAllKeys:@"strKey", @"fuckTheSystemKey", nil];
    assertThatBool(result, equalToBool(NO));
}

// -----------------------------------------------------------------------------

- (void)testSubsetWithKeys {
    NSDictionary *subset = [_dictionary dictionarySubsetWithKeys:@[@"strKey", @"YESBoolKey"]];
    
    assertThat(subset, hasEntry(@"strKey", @"1"));
    assertThat(subset, hasEntry(@"YESBoolKey", equalToBool(YES)));
}

// -----------------------------------------------------------------------------

@end
