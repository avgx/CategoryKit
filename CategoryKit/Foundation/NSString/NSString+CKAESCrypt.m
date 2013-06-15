// The MIT License (MIT)
//
// Copyright (c) 2013 Michael Sedlaczek
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "NSString+CKAESCrypt.h"

@implementation NSString (CKAESCrypt)


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
