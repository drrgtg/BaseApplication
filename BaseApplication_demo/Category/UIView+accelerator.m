//
//  UIView+accelerator.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "UIView+accelerator.h"

@implementation UIView (accelerator)

-(void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

-(CGFloat)height
{
    return self.frame.size.height;
}

-(void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)x
{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setCenter_x:(CGFloat)center_x
{
    self.center = CGPointMake(center_x, self.center.y);
}
-(CGFloat)center_x
{
    return self.center.x;
}

-(void)setCenter_y:(CGFloat)center_y
{
    self.center = CGPointMake(self.center.x, center_y);
}
-(CGFloat)center_y
{
    return self.center.y;
}


-(void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
-(CGSize)size
{
    return self.frame.size;
}

-(void)setPoint:(CGPoint)point
{
    self.frame = CGRectMake(point.x, point.y, self.frame.size.width, self.frame.size.height);
}
-(CGPoint)point
{
    return self.frame.origin;
}

- (CGFloat)left;
{
    return CGRectGetMinX([self frame]);
}

- (void)setLeft:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)top;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTop:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)right;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setRight:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)bottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setBottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

-(void)setCornerRadios:(CGFloat)cornerRadios
{
    self.layer.cornerRadius = cornerRadios;
    self.layer.masksToBounds = YES;
}
-(CGFloat)cornerRadios
{
    return self.layer.cornerRadius;
}


- (void)removeAllSubViews
{
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
}
- (void)removeAllSubviewsExTag:(NSInteger) exTag
{
    for (UIView *subView in self.subviews) {
        if (subView.tag != exTag) {
            [subView removeFromSuperview];
        }
    }
}


+(UIView *)createViewWithFrame:(CGRect)frame
                     backColor:(UIColor *)backColor
                   corneradius:(CGFloat) corner
                   borderWidth:(CGFloat) width
                   borderColor:(UIColor *)borderColor
{
    UIView *tmpView = [[UIView alloc]initWithFrame:frame];
    
    tmpView.backgroundColor = backColor;
    tmpView.layer.borderColor = borderColor.CGColor;
    tmpView.layer.cornerRadius = corner;
    tmpView.layer.masksToBounds = YES;
    tmpView.layer.borderWidth = width;
    
    
    return tmpView;
}



@end
