//
//  NSFileManager+CKExtension.m
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSFileManager+CKExtension.h"
#import "NSString+CKExtension.h"

@implementation NSFileManager (CKExtension)

+ (NSNumber *)fileSize:(NSString *)filePath error:(NSError **)error {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:filePath isDirectory:&isDir] && !isDir) {
        NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:filePath error:error];
        if (fileAttributes)
            return [fileAttributes objectForKey:NSFileSize];
    }
    return nil;
}

// -----------------------------------------------------------------------------

+ (BOOL)isDirectory:(NSString *)filePath {
    BOOL isDir;
    return ([[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDir] && isDir);
}

// -----------------------------------------------------------------------------

+ (BOOL)exist:(NSString *)filePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

// -----------------------------------------------------------------------------

+ (NSString *)temporaryFile:(NSString *)appendPath deleteIfExists:(BOOL)deleteIfExists error:(NSError **)error {
    NSString *tmpFile = NSTemporaryDirectory();
	if (appendPath) tmpFile = [tmpFile stringByAppendingPathComponent:appendPath];
    if (deleteIfExists && [self exist:tmpFile]) {
        [[NSFileManager defaultManager] removeItemAtPath:tmpFile error:error];
    }
    return tmpFile;
}

// -----------------------------------------------------------------------------

+ (BOOL)ensureDirectoryExists:(NSString *)directory created:(BOOL *)created error:(NSError **)error {
	if (![self exist:directory]) {
		BOOL success = [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:error];
		if (success && created) *created = YES;
		return success;
	} else if (![self isDirectory:directory]) {
		if (error) *error = [NSError errorWithDomain:@"CKErrorDomain" code:-1 userInfo:@{NSLocalizedDescriptionKey : NSLocalizedString(@"Path exists but is not a directory", nil)}];
		return NO;
	} else {
		// Path existed and was a directory
		return YES;
	}
}

// -----------------------------------------------------------------------------

+ (NSString *)uniquePathWithNumber:(NSString *)path {
    NSInteger index = 1;
    NSString *uniquePath = path;
    NSString *prefixPath = nil, *pathExtension = nil;
    
    while([self exist:uniquePath]) {
        if (!prefixPath) prefixPath = [path stringByDeletingPathExtension];
        if (!pathExtension) pathExtension = [path fullPathExtension];
        uniquePath = [NSString stringWithFormat:@"%@-%d%@", prefixPath, index, pathExtension];
        index++;
    }
    return uniquePath;
}

// -----------------------------------------------------------------------------

+ (NSString *)pathToResource:(NSString *)path {
    if (!path) return nil;
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:path];
}

// -----------------------------------------------------------------------------

@end
