//
//  NSString+CKExtension.m
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSString+CKExtension.h"

@implementation NSString (CKExtension)

- (NSString *)strip {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// -----------------------------------------------------------------------------

- (BOOL)isBlank {
    return ([@"" isEqualToString:[self strip]]);
}

// -----------------------------------------------------------------------------

+ (BOOL)isBlank:(NSString *)s {
    if (!s) return YES;
    return [s isBlank];
}

// -----------------------------------------------------------------------------

- (BOOL)isEqualIgnoreCase:(NSString *)s {
	return [self compare:s options:NSCaseInsensitiveSearch] == NSOrderedSame;
}

// -----------------------------------------------------------------------------

- (BOOL)contains:(NSString *)contains options:(NSStringCompareOptions)options {
    NSRange range = [self rangeOfString:contains options:options];
    return (range.location != NSNotFound);
}

// -----------------------------------------------------------------------------

- (NSString *)lastSplitWithString:(NSString *)s options:(NSStringCompareOptions)options {
    NSRange range = [self rangeOfString:s options:options];
    if (range.location != NSNotFound) {
        return [self substringWithRange:NSMakeRange(range.location + [s length], [self length] - range.location - [s length])];
    }
    return self;
}

// -----------------------------------------------------------------------------

- (NSArray *)componentsSeparatedByString:(NSString *)separator include:(BOOL)include {
	if (!include) return [self componentsSeparatedByString:separator];
	NSArray *strings = [self componentsSeparatedByString:separator];
	NSMutableArray *components = [NSMutableArray arrayWithCapacity:[strings count] * 2];
	NSInteger i = -1;
	NSInteger count = [strings count];
	for(NSString *s in strings) {
		i++;
		if (![s isEqualToString:@""]) [components addObject:s];
		if ((i+1) < count) [components addObject:separator];
	}
	return components;
}

// -----------------------------------------------------------------------------

- (BOOL)containsCharacters:(NSString *)characters {
    return [self containsAny:[NSCharacterSet characterSetWithCharactersInString:characters]];
}

// -----------------------------------------------------------------------------

- (BOOL)containsAny:(NSCharacterSet *)charSet {
    NSRange range = [self rangeOfCharacterFromSet:charSet];
    return (range.location != NSNotFound);
}

// -----------------------------------------------------------------------------

- (BOOL)only:(NSCharacterSet *)charSet {
    return ![self containsAny:[charSet invertedSet]];
}

// -----------------------------------------------------------------------------

- (BOOL)startsWithAny:(NSCharacterSet *)charSet {
    NSString *firstChar = [self substringToIndex:1];
    return [firstChar containsAny:charSet];
}

// -----------------------------------------------------------------------------

- (BOOL)startsWith:(NSString *)startsWith {
    return [self hasPrefix:startsWith];
}

// -----------------------------------------------------------------------------

- (BOOL)startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options {
    if (!startsWith || [startsWith isEqual:@""]) return NO;
    if ([self length] < [startsWith length]) return NO;
    NSString *beginning = [self substringToIndex:[startsWith length]];
    return ([beginning compare:startsWith options:options] == NSOrderedSame);
}

// -----------------------------------------------------------------------------

- (BOOL)endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options {
    if (!endsWith || [endsWith isEqual:@""]) return NO;
    if ([self length] < [endsWith length]) return NO;
    NSString *lastString = [self substringFromIndex:[self length] - [endsWith length]];
    return ([lastString compare:endsWith options:options] == NSOrderedSame);
}

// -----------------------------------------------------------------------------

- (NSString *)fullPathExtension {
    NSString *extension = [self pathExtension];
    if (![extension isEqualToString:@""]) extension = [NSString stringWithFormat:@".%@", extension];
    return extension;
}

// -----------------------------------------------------------------------------

- (NSInteger)count:(NSString *)s {
	NSRange inRange = NSMakeRange(0, [self length]);
	NSInteger count = 0;
	while(YES) {
		NSRange range = [self rangeOfString:s options:0 range:inRange];
		if (range.location == NSNotFound) break;
		inRange.location = range.location + range.length;
		inRange.length = [self length] - range.location - 1;
		count++;
	}
	return count;
}

// -----------------------------------------------------------------------------

+ (NSMutableCharacterSet *)characterSetsUnion:(NSArray *)characterSets {
    NSMutableCharacterSet *charSet = [NSMutableCharacterSet characterSetWithCharactersInString:@""];
    for(NSCharacterSet *set in characterSets)
        [charSet formUnionWithCharacterSet:set];
    
    return charSet;
}

// -----------------------------------------------------------------------------

@end
