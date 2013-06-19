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

#import "NSArray+CKExtension.h"

@implementation NSArray (CKExtension)

// -------------------------------------------------------------------------------

- (id) firstObject {
    if ([self count] > 0) {
        return [self objectAtIndex:0];
    }
    
    return nil;
}

// -------------------------------------------------------------------------------

- (BOOL) isAllObjectsConformsToProtocol:(Protocol *) protocol {
    for (id object in self) {
        if ([object conformsToProtocol:protocol] == NO) {
            return NO;
        }
    }
    
    return YES;
}

// -------------------------------------------------------------------------------

- (NSArray *) reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
	for(id obj in [self reverseObjectEnumerator]) {
		[array addObject:obj];
	}
	return array;
}

// -----------------------------------------------------------------------------

- (NSArray *) subarrayWithRange:(NSRange) aRange {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = aRange.location; i < aRange.location + aRange.length; i++) {
        if (i >= [self count]) {
            break;
        }
        
        [result addObject:[self objectAtIndex:i]];
    }
    
    return result;
}

// -------------------------------------------------------------------------------

- (NSArray *) subarrayToIndex:(NSInteger) index {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < index; i++) {
        if (i >= [self count]) {
            break;
        }
        
        [result addObject:[self objectAtIndex:i]];
    }
    
    return result;
}

// -------------------------------------------------------------------------------

- (NSArray *) subarrayFromIndex:(NSInteger) index {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = index; i < [self count]; i++) {
        if (i >= [self count]) {
            break;
        }
        
        [result addObject:[self objectAtIndex:i]];
    }
    
    return result;
}

// -----------------------------------------------------------------------------

- (NSArray *) filteredArrayUsingPredicateWithFormat:(NSString *) format, ... {
    va_list args;
    va_start(args, format);
    
    NSPredicate *filter = [NSPredicate predicateWithFormat:format arguments:args];
    
    va_end(args);
    
    if (!filter) {
        return nil;
    }
    
    return [self filteredArrayUsingPredicate:filter];
}

// -----------------------------------------------------------------------------

@end
