//
//  NSFileManager+CKExtension.h
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (CKExtension)

/*!
 Get size of file.
 
 @param filePath Path
 @param error Out error
 @result File size
 */
+ (NSNumber *)fileSize:(NSString *)filePath error:(NSError **)error;

/*!
 Check if path is a directory.
 
 @param filePath Path
 @result YES if directory, NO otherwise
 */
+ (BOOL)isDirectory:(NSString *)filePath;

/*!
 Check if path exists.
 
 @param filePath Path
 @result YES if exists, NO otherwise
 */
+ (BOOL)exist:(NSString *)filePath;

/*!
 Get path to temporary file.
 
 @param appendPath Path to append to temporary directory name, if not nil
 @param deleteIfExists Will delete existing file if it is in the way
 @param error If not nil, will be set if an error occurs
 @result Path for temporary file
 */
+ (NSString *)temporaryFile:(NSString *)appendPath deleteIfExists:(BOOL)deleteIfExists error:(NSError **)error;

/*!
 Get unique filename based on the specified path.
 If file does not exist, the same object is returned.
 If file does exist a unique variation is returned.
 
 @param path Path
 @result If, for example, foo.txt already exists, will return foo-1.txt, and if that exists foo-2.txt, and so on.
 */
+ (NSString *)uniquePathWithNumber:(NSString *)path;

/*!
 Ensure directory exists.
 
 @param directory Directory
 @param created Set if was created
 @param error If not nil, will set if error occurs
 @result YES If directory exists or was created
 */
+ (BOOL)ensureDirectoryExists:(NSString *)directory created:(BOOL *)created error:(NSError **)error;

/*!
 Path to resource in main bundle.
 
 @param path Path
 @result Full path in resource in main bundle.
 */
+ (NSString *)pathToResource:(NSString *)path;

@end
