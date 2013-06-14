//
//  NSString+SHA256.m
//  Yakimbi
//
//  Created by Lisovoy Ivan on 1/21/13.
//  Copyright (c) 2013 Yakimbi. All rights reserved.
//

#import "NSString+SHA256.h"
#import "NSData+AESCrypt.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation NSString (SHA256)

// -------------------------------------------------------------------------------

- (NSString *) sha256 {
    @try {
        
    const char *cKey=[self cStringUsingEncoding:NSASCIIStringEncoding];
    if (cKey == NULL) {
        [NSException raise:NSInternalInconsistencyException format:@"sha256 input string is incorrect"];
    }
        
    NSData *keyData=[NSData dataWithBytes:cKey length:strlen(cKey)];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH]={0};
    
    CC_SHA256(keyData.bytes, keyData.length, digest);
    NSData *out=[NSData dataWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    NSString *hash=[out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    return hash;
    }
    @catch (NSException *exception) {
        return [[NSProcessInfo processInfo] globallyUniqueString];
    }
    
}

// -------------------------------------------------------------------------------

- (NSString *) hmac_sha256WithBase64EncodingWithKey:(NSString *)key {
    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
    const char *cData = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:sizeof(cHMAC)];
    NSString *hash = [HMAC base64Encoding];
    
    return hash;
}

// -------------------------------------------------------------------------------

@end
