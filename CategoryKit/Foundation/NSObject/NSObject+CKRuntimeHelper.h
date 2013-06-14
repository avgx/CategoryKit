//
//  NSObject+RuntimeHelper.h
//  CSite
//
//  Created by Denis Kotenko on 21.01.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (CKRuntimeHelper)

+ (Class) propertyClassForPropertyName:(NSString *) propertyName ofClass:(Class) klass;
+ (NSArray *) propertyNames:(Class) klass;

@end
