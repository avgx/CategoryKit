//
//  UIImage+Extensions.m
//  HU.GE
//
//  Created by Ivan Lisovoy on 9/3/12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import "UIImage+CKTransform.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (CKTransform)

#define DEGREES_TO_RADIANS(DEGREES) (DEGREES * (M_PI / 180.0f)) 

// -------------------------------------------------------------------------------

- (UIImage *) scaleToFitSize:(CGSize) newSize {
    CGFloat wFactor = newSize.width / self.size.width;
    CGFloat hFactor = newSize.height / self.size.height;
    CGFloat factor = MAX(wFactor, hFactor);
    
    CGSize size = CGSizeMake(self.size.width * factor, self.size.height * factor);
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                size.width,
                                                size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
	if (!bitmap) {
		return nil;
    }
    
	CGContextSetShouldAntialias(bitmap, YES);
	CGContextSetAllowsAntialiasing(bitmap, YES);
	CGContextSetInterpolationQuality(bitmap, kCGInterpolationHigh);
    
    UIGraphicsPushContext(bitmap);
    CGContextTranslateCTM(bitmap, 0.0f, size.height);
    CGContextScaleCTM(bitmap, 1.0f, -1.0f);
    CGRect rect = {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = size.width, .size.height = size.height};
    [self drawInRect:rect];    
    UIGraphicsPopContext();
    
	CGImageRef scaledImageRef = CGBitmapContextCreateImage(bitmap);
	UIImage* scaled = [UIImage imageWithCGImage:scaledImageRef];
    
	CGImageRelease(scaledImageRef);
	CGContextRelease(bitmap);
    
    return scaled;
}

// -------------------------------------------------------------------------------

- (UIImage *) scaleToSize:(CGSize) newSize {
    const size_t originalWidth = self.size.width;
	const size_t originalHeight = self.size.height;
    
	size_t width, height;
	if (originalWidth > originalHeight) {
		width = newSize.width;
		height = originalHeight * newSize.width / originalWidth;
	}
	else {
		height = newSize.height;
		width = originalWidth * newSize.height / originalHeight;
	}
    
	if (height > newSize.width) { 
		width = newSize.width; 
		height = originalHeight * newSize.width / originalWidth; 
	} 
    
	if (height > newSize.height) { 
		height = newSize.height; 
		width = originalWidth * newSize.height / originalHeight; 
	}
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                width,
                                                height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));

    if (!bitmap) {
        return nil;
    }
    
	CGContextSetInterpolationQuality(bitmap, kCGInterpolationNone);

    UIGraphicsPushContext(bitmap);
    CGContextTranslateCTM(bitmap, 0.0f, height);
    CGContextScaleCTM(bitmap, 1.0f, -1.0f);
    CGRect rect = {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height};
    [self drawInRect:rect];    
    UIGraphicsPopContext();
    
	CGImageRef scaledImageRef = CGBitmapContextCreateImage(bitmap);
	UIImage* scaled = [UIImage imageWithCGImage:scaledImageRef];
    
	CGImageRelease(scaledImageRef);
	CGContextRelease(bitmap);
    
	return scaled;	
}

// -------------------------------------------------------------------------------

- (UIImage *) cropImage:(CGSize) newSize {
    return [self cropImage:newSize mode:ImageCropModeTopLeft];
}

// -------------------------------------------------------------------------------

- (UIImage *) cropToRect:(CGRect) rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return croppedImage;
}

// -------------------------------------------------------------------------------

- (UIImage *) cropImage:(CGSize) newSize mode:(ImageCropMode) cropMode {
    const CGSize size = self.size;
	CGFloat x = 0;
    CGFloat y = 0;
    
	switch (cropMode) {
		case ImageCropModeTopLeft:
			x = y = 0.0f;
			break;
		case ImageCropModeTopCenter:
			x = (size.width - newSize.width) * 0.5f;
			y = 0.0f;
			break;
		case ImageCropModeTopRight:
			x = size.width - newSize.width;
			y = 0.0f;
			break;
		case ImageCropModeBottomLeft:
			x = 0.0f;
			y = size.height - newSize.height;
			break;
		case ImageCropModeBottomCenter:
			x = newSize.width * 0.5f;
			y = size.height - newSize.height;
			break;
		case ImageCropModeBottomRight:
			x = size.width - newSize.width;
			y = size.height - newSize.height;
			break;
		case ImageCropModeLeftCenter:
			x = 0.0f;
			y = (size.height - newSize.height) * 0.5f;
			break;
		case ImageCropModeRightCenter:
			x = size.width - newSize.width;
			y = (size.height - newSize.height) * 0.5f;
			break;
		case ImageCropModeCenter:
			x = (size.width - newSize.width) * 0.5f;
			y = (size.height - newSize.height) * 0.5f;
			break;
		default:
			x = y = 0.0f;
			break;
	}
    
    CGRect cropRect = CGRectMake(x * self.scale, y * self.scale, newSize.width * self.scale, newSize.height * self.scale);
    
	CGImageRef croppedImageRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
	UIImage* cropped = [UIImage imageWithCGImage:croppedImageRef scale:self.scale orientation:self.imageOrientation];
    
	CGImageRelease(croppedImageRef);
    
	return cropped;
}

// -------------------------------------------------------------------------------

- (UIImage *) rotateInRadians:(float) radians {
	const size_t width = self.size.width * self.scale;
	const size_t height = self.size.height * self.scale;
    
	CGRect imgRect = (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height};
	CGRect rotatedRect = CGRectApplyAffineTransform(imgRect, CGAffineTransformMakeRotation(radians));
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                rotatedRect.size.width,
                                                rotatedRect.size.height,
                                                8,
                                                0,
                                                colorSpace,
                                                kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    CGColorSpaceRelease(colorSpace);
    if (!bitmap) {
        return nil;
    }
	
	CGContextSetShouldAntialias(bitmap, true);
	CGContextSetAllowsAntialiasing(bitmap, true);
	CGContextSetInterpolationQuality(bitmap, kCGInterpolationHigh);
    
	CGContextTranslateCTM(bitmap, +(rotatedRect.size.width * 0.5f), +(rotatedRect.size.height * 0.5f));
	CGContextRotateCTM(bitmap, radians);
    
    CGRect rect = {.origin.x = -(width * 0.5f), .origin.y = -(height * 0.5f), .size.width = width, .size.height = height};
	CGContextDrawImage(bitmap, rect, self.CGImage);
    
	CGImageRef rotatedImageRef = CGBitmapContextCreateImage(bitmap);
	UIImage* rotated = [UIImage imageWithCGImage:rotatedImageRef scale:self.scale orientation:self.imageOrientation];
    

	CGImageRelease(rotatedImageRef);
	CGContextRelease(bitmap);
    
	return rotated;
}

// -------------------------------------------------------------------------------

- (UIImage *) rotateInDegrees:(float) degrees {
	return [self rotateInRadians:DEGREES_TO_RADIANS(degrees)];
}

// -------------------------------------------------------------------------------'

+ (UIImage *) normalizeImage:(UIImage *) image {
    CGFloat kMaxResolution = NSUIntegerMax;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight = 0;
    UIImageOrientation orientation = image.imageOrientation;
    
    switch(orientation) {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orientation == UIImageOrientationRight || orientation == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

// -------------------------------------------------------------------------------

@end
