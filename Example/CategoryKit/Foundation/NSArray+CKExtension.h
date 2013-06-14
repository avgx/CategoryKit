//
//  NSArray.h
//  PickAndRoll
//
//  Created by macuser on 15.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

@interface NSArray (CKExtension)

- (id) firstObject;

- (NSArray *) subarrayWithRange:(NSRange) aRange;
- (NSArray *) subarrayToIndex:(NSInteger) index;
- (NSArray *) subarrayFromIndex:(NSInteger) index;

- (NSArray *) filteredArrayUsingPredicateWithFormat:(NSString*) format, ...;

@end
