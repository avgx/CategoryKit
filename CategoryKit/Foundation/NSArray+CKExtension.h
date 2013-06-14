//
//  NSArray.h
//  PickAndRoll
//
//  Created by Denis Kotenko on 15.09.11.
//  Copyright 2011 Ramotion. All rights reserved.
//

@interface NSArray (CKExtension)

- (id) firstObject;

- (NSArray *) subarrayWithRange:(NSRange) aRange;
- (NSArray *) subarrayToIndex:(NSInteger) index;
- (NSArray *) subarrayFromIndex:(NSInteger) index;

- (NSArray *) filteredArrayUsingPredicateWithFormat:(NSString *) format, ...;

@end
