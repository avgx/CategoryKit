//
//  NSString+CKFlippedTests.m
//  CategoryKit
//
//  Created by Lisovoy Ivan on 6/23/13.
//  Copyright (c) 2013 Lisovoy Ivan. All rights reserved.
//

#import "NSString+CKFlipped.h"
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

@interface NSString_CKFlippedTests : SenTestCase

@end


@implementation NSString_CKFlippedTests

// -----------------------------------------------------------------------------

- (void) testFlipEmptyString {
    NSString *sup = nil;
    assertThat([sup flipped], nilValue());
}

// -----------------------------------------------------------------------------

- (void) testFlipEnglishLetterString {
    NSString *sup = @"test";
    assertThat([sup flipped], equalTo(@"\u0287\u01DDs\u0287"));
}

// -----------------------------------------------------------------------------

- (void)testFlipNonEnglishLetterString {
    NSString *sup = @"тест";
    assertThat([sup flipped], equalTo(@"тест"));
}

// -----------------------------------------------------------------------------

@end