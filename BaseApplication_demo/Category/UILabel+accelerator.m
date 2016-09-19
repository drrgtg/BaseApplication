//
//  UILabel+accelerator.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "UILabel+accelerator.h"

@implementation UILabel (accelerator)

+(UILabel *)createMutableLineLabelWithSize:(CGSize )size
                                  andPoint:(CGPoint)point
                                      font:(UIFont *)font
                              numberOfLine:(NSInteger)numberLine
                              textAlgnMent:(NSTextAlignment )align
                                 textColor:(UIColor *)textColor
                           BackGroundColor:(UIColor *)backGroundColor
                                       str:(NSString *)str
{
    CGSize textSize = [str sizeWithtextFont:font size:size];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y, textSize.width, textSize.height)];
    label.numberOfLines = numberLine;
    label.textAlignment = align;
    label.textColor = textColor;
    label.backgroundColor = backGroundColor;
    label.text = str;
    
    label.userInteractionEnabled = YES;
    return label;
}
@end
