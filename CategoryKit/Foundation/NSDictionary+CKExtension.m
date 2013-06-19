// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSDictionary+CKExtension.h"

@implementation NSDictionary (CKExtension)

// -----------------------------------------------------------------------------

- (float)floatForKey:(id)key {
    id value = [self objectForKey:key];
	return value ? [value doubleValue] : 0.0;
}

// -----------------------------------------------------------------------------

- (NSInteger)integerForKey:(id)key {
    id value = [self objectForKey:key];
	return value ? [value integerValue] : 0;
}

// -----------------------------------------------------------------------------

- (NSUInteger)unsignedIntegerForKey:(id)key {
    id value = [self objectForKey:key];
	return value ? [value unsignedIntegerValue] : 0;
}

// -----------------------------------------------------------------------------

- (NSNumber *)numberForKey:(id)key {
    id value = [self objectForKey:key];
	if (!value || [value isEqual:[NSNull null]]) {
        return nil;
    }
    
    NSAssert([value isKindOfClass:[NSNumber class]], @"Value must be a NSNumber");
    
	return value;
}

// -----------------------------------------------------------------------------

- (BOOL)boolForKey:(id)key {
    id value = [self objectForKey:key];
	return value ? [value boolValue] : NO;
}


// -----------------------------------------------------------------------------

- (BOOL)hasAllKeys:(NSString *)firstKey, ... {
	va_list vl;
	va_start(vl, firstKey);
	id key = firstKey;
	while(key != nil) {
		id value = [self objectForKey:key];
		if (!value || [value isEqual:[NSNull null]]) {
            return NO;
        }
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
        if (value) {
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}

// -----------------------------------------------------------------------------

@end
