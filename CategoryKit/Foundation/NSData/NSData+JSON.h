//
//  NSData+JSON.h
//  CSite
//
//  Created by Denis Kotenko on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (JSON)

- (id) objectFromJSONData:(NSError **) error;

@end
