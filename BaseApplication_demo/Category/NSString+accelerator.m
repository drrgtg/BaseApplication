//
//  NSString+accelerator.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "NSString+accelerator.h"

@implementation NSString (accelerator)
-(CGSize)sizeWithtextFont:(UIFont *)font size:(CGSize)size
{
    CGSize tmpSize = CGSizeZero;
    
    tmpSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    
    
    return tmpSize;
}
@end
