//
//  NSNumber+CKHumanize.h
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CKHumanize)

/*!
 File size label.
 
 @result '904 b', '32 KB', '1.1 MB',
 */
- (NSString *)humanSize;

/*!
 File size label.
 
 @param delimiter In between numeric and unit
 @result '904 b', '32 KB', '1.1 MB',
 */
- (NSString *)humanSizeWithDelimiter:(NSString *)delimiter;

@end
