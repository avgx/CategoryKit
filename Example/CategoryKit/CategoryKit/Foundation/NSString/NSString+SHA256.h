//
//  NSString+SHA256.h
//  Yakimbi
//
//  Created by Lisovoy Ivan on 1/21/13.
//  Copyright (c) 2013 Yakimbi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SHA256)

- (NSString *) sha256;
- (NSString *) hmac_sha256WithBase64EncodingWithKey:(NSString *)key;

@end
