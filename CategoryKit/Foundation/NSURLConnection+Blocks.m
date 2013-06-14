//
//  MyClass.m
//  Pocket Pics
//
//  Created by Denis on 24.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSURLConnection+Blocks.h"

@implementation NSURLConnection (Blocks)

// -----------------------------------------------------------------------------

+ (void)asyncRequest:(NSURLRequest *)request
             success:(void(^)(NSData *, NSURLResponse *))successBlock_
             failure:(void(^)(NSData *, NSError *))failureBlock_ {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLResponse *response = nil;
        NSError *error = nil;

        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:&response
                                                         error:&error];
        
        if (error) {
            failureBlock_(data,error);
        } else {
            successBlock_(data,response);
        }
        
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    });
}

// -----------------------------------------------------------------------------

@end

