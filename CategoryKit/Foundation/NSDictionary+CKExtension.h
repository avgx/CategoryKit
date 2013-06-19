// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko, Yaroslav Bulda
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

#import <Foundation/Foundation.h>

@interface NSDictionary (CKExtension)


/*!
 Get double value for key.
 
 @param key Key
 @result Double value
 */
- (float)floatForKey:(id)key;

/*!
 Integer for key.
 If value for key is nil or [NSNull null], 0 is returned.
 
 @param key Key
 @result Integer value
 */
- (NSInteger)integerForKey:(id)key;


/*!
 Unsigned integer for key.
 If value for key is nil or [NSNull null], 0 is returned.
 
 @param key Key
 @result Unsigned integer
 */
- (NSUInteger)unsignedIntegerForKey:(id)key;

/*!
 Number for key.
 @param key
 @result Number
 */
- (NSNumber *)numberForKey:(id)key;

/*!
 Get BOOL value for key.
 
 @param key Key
 @result YES if boolValue; If key not found or is NSNull, returns NO.
 */
- (BOOL)boolForKey:(id)key;

/*!
 Check if dictionary has all keys.
 
 @param firstKey First key
 @param ... Argument list
 @result YES if dictionary has all the keys
 */
- (BOOL)hasAllKeys:(NSString *)firstKey, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 Return dictionary with subset of keys.
 
 @param keys Keys
 */
- (NSDictionary *)dictionarySubsetWithKeys:(NSArray *)keys;

@end
