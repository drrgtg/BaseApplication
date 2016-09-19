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




@end

