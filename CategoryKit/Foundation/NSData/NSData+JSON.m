//
//  NSData+JSON.m
//  CSite
//
//  Created by Denis Kotenko on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)

// -------------------------------------------------------------------------------

- (id) objectFromJSONData:(NSError **) error {
    id object = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:error];
    if (error != nil) {
        return nil;
    }
    return object;
}

// -------------------------------------------------------------------------------

@end
