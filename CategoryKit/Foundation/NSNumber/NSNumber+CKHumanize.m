//
//  NSNumber+CKHumanize.m
//  CategotyKit
//
//  Created by Ivan Lisovoy on 14.06.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "NSNumber+CKHumanize.h"

@implementation NSNumber (CKHumanize)

// -----------------------------------------------------------------------------

- (NSString *)humanSize {
    return [self humanSizeWithDelimiter:@" "];
}

// -----------------------------------------------------------------------------

- (NSString *)humanSizeWithDelimiter:(NSString *)delimiter {
    double value = [self doubleValue];
	double byteTest = 1024;
	double kilobyteTest = 1024 * byteTest;
	double megaByteTest = 1024 * kilobyteTest;
    
    if (value < byteTest) {
        return [NSString stringWithFormat:@"%.0f%@B", value, delimiter];
    }
    else if (value < kilobyteTest) {
        double d = value / byteTest;
        return [NSString stringWithFormat:@"%.0f%@KB", d, delimiter];
    }
    else if (value < megaByteTest) {
        double d = value / kilobyteTest;
        return [NSString stringWithFormat:@"%.1f%@MB", d, delimiter];
    }
    else {
		double d = value / megaByteTest;
		return [NSString stringWithFormat:@"%.2f%@GB", d, delimiter];
    }
    
    return nil;
}

// -----------------------------------------------------------------------------

@end
