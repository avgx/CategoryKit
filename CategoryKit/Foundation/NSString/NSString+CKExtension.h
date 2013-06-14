//
//  NSString+CKExtension.h
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (CKExtension)

/*!
 Check if equals ignoring case.
 
 @param s String
 @result True if equal regardless of case
 */
- (BOOL)isEqualIgnoreCase:(NSString *)s;

/*!
 Strip whitespace from left and right side of string.
 
 @result String with characters trimmed
 */
- (NSString *)strip;

/*!
 Count the number of times a string appears.
 
 @param s String
 @result Number of times it appears
 */
- (NSInteger)count:(NSString *)s;

/*!
 Check if string is blank.
 
 @param s String
 @result YES if string is nil, empty or whitespace characters
 */
+ (BOOL)isBlank:(NSString *)s;

/*!
 Check if string contains ANY characters from a string.
 
 @param characters String representing characters to check for
 @result YES If string contains characters
 */
- (BOOL)containsCharacters:(NSString *)characters;

/*!
 Check if string contains ANY characters from a set.
 
 @param charSet Char set
 @result YES If string contains any characters
 */
- (BOOL)containsAny:(NSCharacterSet *)charSet;

/*!
 Check if string contains only characters from a set.
 
 @param charSet Character set
 @result YES If string contains only these characters
 */
- (BOOL)only:(NSCharacterSet *)charSet;

/*!
 Check if string starts with any of the character set.
 
 @param charSet Character set.
 */
- (BOOL)startsWithAny:(NSCharacterSet *)charSet;

/*!
 Check if string starts with a string.
 
 Returns NO if startsWith is empty.
 
 @param startsWith String to check
 @result YES if string starts with string
 */
- (BOOL)startsWith:(NSString *)startsWith;

/*!
 Check if string starts with a string.
 
 Returns NO if startsWith is empty.
 
 @param startsWith String to check
 @param options Compare options
 @result YES if string starts with string
 */
- (BOOL)startsWith:(NSString *)startsWith options:(NSStringCompareOptions)options;

/*!
 Check if string ends with a string.
 
 Returns NO if endsWith is empty.
 
 @param endsWith String to check
 @param options Compare options
 @result YES if string ends with string
 */
- (BOOL)endsWith:(NSString *)endsWith options:(NSStringCompareOptions)options;

/*!
 Check if self contains the specified string with options
 
 @param contains String to look for
 @param options Options
 @result YES if string has the substring
 */
- (BOOL)contains:(NSString *)contains options:(NSStringCompareOptions)options;

/*!
 Path extension with . or "" as before.
 
 "spliff.tiff" => ".tiff"
 "spliff" => ""
 
 @result Full path extension with .
 */
- (NSString *)fullPathExtension;

/*!
 Combine character sets.
 
 @param characterSets Character sets to union
 @result Combined character sets
 */
+ (NSMutableCharacterSet *)characterSetsUnion:(NSArray *)characterSets;

@end
