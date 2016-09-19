//
//  UILabel+accelerator.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (accelerator)

+(UILabel *)createMutableLineLabelWithSize:(CGSize )size
                                  andPoint:(CGPoint)point
                                     font:(UIFont *)font
                             numberOfLine:(NSInteger)numberLine
                             textAlgnMent:(NSTextAlignment )align
                                textColor:(UIColor *)textColor
                          BackGroundColor:(UIColor *)backGroundColor
                                      str:(NSString *)str;

@end
