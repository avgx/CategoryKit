//
//  NSDictionary+CKExtension.m
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSDictionary+CKExtension.h"

@implementation NSDictionary (CKExtension)

// -----------------------------------------------------------------------------

- (double)doubleForKey:(id)key withDefault:(double)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value doubleValue];
}

// -----------------------------------------------------------------------------

- (double)doubleForKey:(id)key {
	return [self doubleForKey:key withDefault:0];
}

// -----------------------------------------------------------------------------

- (NSInteger)integerForKey:(id)key withDefault:(NSInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value integerValue];
}

// -----------------------------------------------------------------------------

- (NSInteger)integerForKey:(id)key {
	return [self integerForKey:key withDefault:0];
}

// -----------------------------------------------------------------------------

- (NSUInteger)unsignedIntegerForKey:(id)key withDefault:(NSUInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value unsignedIntegerValue];
}

// -----------------------------------------------------------------------------

- (NSUInteger)unsignedIntegerForKey:(id)key {
	return [self unsignedIntegerForKey:key withDefault:0];
}

// -----------------------------------------------------------------------------

- (NSNumber *)numberForKey:(id)key {
    id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return nil;
    NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

// -----------------------------------------------------------------------------

- (NSNumber *)numberForKey:(id)key withDefaultInteger:(NSInteger)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithInteger:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

// -----------------------------------------------------------------------------

- (NSNumber *)numberForKey:(id)key withDefaultDouble:(double)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithDouble:defaultValue];
	NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
	return value;
}

// -----------------------------------------------------------------------------

- (BOOL)boolForKey:(id)key withDefault:(BOOL)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return [value boolValue];
}

// -----------------------------------------------------------------------------

- (BOOL)boolForKey:(id)key {
	return [self boolForKey:key withDefault:NO];
}

// -----------------------------------------------------------------------------

- (NSNumber *)boolValueForKey:(id)key withDefault:(BOOL)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return [NSNumber numberWithBool:defaultValue];
	return [NSNumber numberWithBool:[value boolValue]];
}

// -----------------------------------------------------------------------------

- (NSNumber *)boolValueForKey:(id)key {
	return [self boolValueForKey:key withDefault:NO];
}

// -----------------------------------------------------------------------------

- (id)objectForKey:(id)key withDefault:(id)defaultValue {
	id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) return defaultValue;
	return value;
}

// -----------------------------------------------------------------------------

- (id)objectForKeyOrNSNull:(id)key {
	return [self objectForKey:key withDefault:[NSNull null]];
}

// -----------------------------------------------------------------------------

- (BOOL)hasAllKeys:(NSString *)firstKey, ... {
	va_list vl;
	va_start(vl, firstKey);
	id key = firstKey;
	while(key != nil) {
		id value = [self objectForKey:key];
		if (!value || [value isEqual:[NSNull null]]) return NO;
		key = va_arg(vl, NSString *);
	}
	va_end(vl);
	return YES;
}

// -----------------------------------------------------------------------------

- (NSDictionary *)dictionarySubsetWithKeys:(NSArray *)keys {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:[keys count]];
    for(id key in keys) {
        id value = [self objectForKey:key];
        if (value) [dict setObject:value forKey:key];
    }
    return dict;
}

// -----------------------------------------------------------------------------

@end
