//
//  UIView+accelerator.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (accelerator)
/**
 *  width
 */
@property (nonatomic)CGFloat   width;
/**
 *  height
 */
@property (nonatomic)CGFloat   height;
/**
 *  point x
 */
@property (nonatomic)CGFloat   x;
/**
 *  point y
 */
@property (nonatomic)CGFloat   y;
/**
 *  centerX
 */
@property (nonatomic)CGFloat   center_x;
/**
 *  centerY
 */
@property (nonatomic)CGFloat   center_y;
/**
 *  size
 */
@property (nonatomic)CGSize   size;
/**
 *  point
 */
@property (nonatomic)CGPoint   point;
/**
 *  left
 */
@property (nonatomic)CGFloat   left;
/**
 *  right
 */
@property (nonatomic)CGFloat   right;
/**
 *  top
 */
@property (nonatomic)CGFloat   top;
/**
 *  bottom
 */
@property (nonatomic)CGFloat   bottom;
/**
 *  cornerRadios
 *  default maskstobounds
 */
@property (nonatomic)CGFloat   cornerRadios;

/**
 *  remove all subViews
 */
- (void)removeAllSubViews;
/**
 *  remove all subViews exclude some tag
 */
-(void)removeAllSubviewsExTag:(NSInteger) exTag;
/**
 *  quick to get a UIView
 *
 *  @param frame     frame
 *  @param backColor bakcgroundColor
 *  @param corner    cornerRadius
 *
 *  @return UIView
 */
+(UIView *)createViewWithFrame:(CGRect)frame
                     backColor:(UIColor *)backColor
                   corneradius:(CGFloat) corner
                   borderWidth:(CGFloat) width
                   borderColor:(UIColor *)borderColor;
@end
