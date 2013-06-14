//
//  NSObject+RuntimeHelper.m
//  CSite
//
//  Created by Denis Kotenko on 21.01.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSObject+CKRuntimeHelper.h"
#import <objc/runtime.h>

static const char *property_getTypeName(objc_property_t property) {
	const char *attributes = property_getAttributes(property);
	char buffer[1 + strlen(attributes)];
	strcpy(buffer, attributes);
	char *state = buffer, *attribute;
	while ((attribute = strsep(&state, ",")) != NULL) {
		if (attribute[0] == 'T') {
			size_t len = strlen(attribute);
			attribute[len - 1] = '\0';
			return (const char *)[[NSData dataWithBytes:(attribute + 3) length:len - 2] bytes];
		}
	}
	return "@";
}


@implementation NSObject (CKRuntimeHelper)

// -------------------------------------------------------------------------------

+ (NSArray *) propertyNames:(Class) klass {
	NSMutableArray *propertyNames = [[NSMutableArray alloc] init];
	unsigned int propertyCount = 0;
	objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
	
	for (unsigned int i = 0; i < propertyCount; ++i) {
		objc_property_t property = properties[i];
		const char * name = property_getName(property);
		
		[propertyNames addObject:[NSString stringWithUTF8String:name]];
	}
	free(properties);
	
	return propertyNames;
}

// -------------------------------------------------------------------------------

+ (Class) propertyClassForPropertyName:(NSString *) propertyName ofClass:(Class) klass {
	unsigned int propertyCount = 0;
	objc_property_t *properties = class_copyPropertyList(klass, &propertyCount);
	
	const char * cPropertyName = [propertyName UTF8String];
	
	for (unsigned int i = 0; i < propertyCount; ++i) {
		objc_property_t property = properties[i];
		const char * name = property_getName(property);
        
		if (strcmp(cPropertyName, name) == 0) {
			free(properties);
			NSString *className = [NSString stringWithUTF8String:property_getTypeName(property)];
			return NSClassFromString(className);
		}
	}
    
	free(properties);
	return nil;
}

// -------------------------------------------------------------------------------

@end
