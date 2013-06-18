//
//  NSArray.m
//  PickAndRoll
//
//  Created by Denis Kotenko on 15.09.11.
//  Copyright 2011 Ramotion. All rights reserved.
//

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

- (NSArray *) subarrayWithRange:(NSRange) aRange {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = aRange.location; i < aRange.location + aRange.length; i++) {
        if (i >= [self count]) break;
        [result addObject:[self objectAtIndex:i]];
    }
    
    return result;
}

// -------------------------------------------------------------------------------

- (NSArray *) subarrayToIndex:(NSInteger) index {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < index; i++) {
        if (i >= [self count]) break;
        [result addObject:[self objectAtIndex:i]];
    }
    
    return result;
}

// -------------------------------------------------------------------------------

- (NSArray *) subarrayFromIndex:(NSInteger) index {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = index; i < [self count]; i++) {
        if (i >= [self count]) break;
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
