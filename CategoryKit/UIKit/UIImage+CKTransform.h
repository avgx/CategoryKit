//
//  UIImage+Extensions.h
//  HU.GE
//
//  Created by Ivan Lisovoy on 9/3/12.
//  Copyright (c) 2012 Ramotion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	ImageCropModeTopLeft,
	ImageCropModeTopCenter,
	ImageCropModeTopRight,
	ImageCropModeBottomLeft,
	ImageCropModeBottomCenter,
	ImageCropModeBottomRight,
	ImageCropModeLeftCenter,
	ImageCropModeRightCenter,
	ImageCropModeCenter
} ImageCropMode;


@interface UIImage (CKTransform)

- (UIImage *) scaleToFitSize:(CGSize) newSize;
- (UIImage *) scaleToSize:(CGSize) newSize;

- (UIImage *) cropToRect:(CGRect) rect;
- (UIImage *) cropImage:(CGSize) newSize;
- (UIImage *) cropImage:(CGSize) newSize mode:(ImageCropMode) cropMode;

- (UIImage *) rotateInRadians:(float) radians;
- (UIImage *) rotateInDegrees:(float) degrees;

+ (UIImage *) normalizeImage:(UIImage *) image;

@end
