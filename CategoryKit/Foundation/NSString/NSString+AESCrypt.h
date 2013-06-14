//
//  NSString+AESCrypt.h
//
//  Created by Michael Sedlaczek, Gone Coding on 2011-02-22
//

#import <Foundation/Foundation.h>
#import "NSData+AESCrypt.h"

@interface NSString (AESCrypt)

- (NSString *)AES256EncryptWithKey:(NSString *)key;
- (NSString *)AES256DecryptWithKey:(NSString *)key;
- (NSString *)AES256EncryptWithKeyAndBase64:(NSString *)key;
- (NSString *)AES256DecryptWithKeywithBase64:(NSString *)key;

@end
