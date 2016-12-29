//
//  UIImage+color.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (color)
/**
 *  color to circle UIImage
 *
 *  @param color  UIColor
 *  @param radius radius
 *  @param size   size
 *
 *  @return UIImage
 */
+ (UIImage *)cornerImage:(UIColor*)color radius:(CGFloat) radius andSize:(CGSize)size;
/**
 *  color to rectangle UIImage
 *
 *  @param color UIColor
 *  @param size  CGSize
 *
 *  @return UIImage
 */
+ (UIImage *)rectImageWithColor:(UIColor *) color andRect:(CGSize)size;

@end

@interface UIImage (accelerator)

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */

+ (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size;

@end

