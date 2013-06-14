//
//  NSString+AESCrypt.m
//
//  Created by Michael Sedlaczek, Gone Coding on 2011-02-22
//

#import "NSString+AESCrypt.h"

@implementation NSString (AESCrypt)


- (NSString *)AES256EncryptWithKeyAndBase64:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString * base64String = [plainData base64Encoding];
    
    plainData = [base64String dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];
    
    NSString *encryptedString = [encryptedData base64Encoding];
    
    return encryptedString;
}

- (NSString *)AES256EncryptWithKey:(NSString *)key
{
    NSData *plainData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encryptedData = [plainData AES256EncryptWithKey:key];

    NSString *encryptedString = [encryptedData base64Encoding];

    return encryptedString;
}

- (NSString *)AES256DecryptWithKey:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];

    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];

    return plainString;
}

- (NSString *)AES256DecryptWithKeywithBase64:(NSString *)key
{
    NSData *encryptedData = [NSData dataWithBase64EncodedString:self];
    
    NSData *plainData = [encryptedData AES256DecryptWithKey:key];
    
    NSString *base64String = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    plainData  = [NSData dataWithBase64EncodedString:base64String];
    
    NSString *plainString = [[NSString alloc] initWithData:plainData encoding:NSUTF8StringEncoding];
    
    return plainString;
}


@end
