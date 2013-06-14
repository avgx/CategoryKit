//
//  NSDate+netConversion.h
//  RitzPix-Phoenix
//
//  Created by yaroslav-imac on 12/21/12.
//  Copyright (c) 2012 Anton. All rights reserved.
//

@interface NSDate (CKNetConversion)

+ (NSDate *)dateFromDotNet:(NSString *)stringDate;
- (NSString *)dateToDotNet;

@end
