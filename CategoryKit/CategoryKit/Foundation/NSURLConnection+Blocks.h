//
//  MyClass.h
//  Pocket Pics
//
//  Created by Denis on 24.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLConnection (Blocks)

+ (void)asyncRequest:(NSURLRequest *)request
             success:(void(^)(NSData *, NSURLResponse *))successBlock_
             failure:(void(^)(NSData *, NSError *))failureBlock_;

@end

