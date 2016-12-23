//
//  ULSegmentControl.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/23.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ULSegmentControl : UIView

/**
 default is darkTextColor
 */
@property (strong, nonatomic) UIColor   *textColor;

/**
 default is green
 */
@property (strong, nonatomic) UIColor   *selectedColor;

/**
 default is white
 */
@property (strong, nonatomic) UIColor   *tintColor;

/**
 default is system 15
 */
@property (strong, nonatomic) UIFont   *textFont;

/**
 default is 0
 */
@property (assign, nonatomic) NSUInteger   seletedIndex;


- (instancetype)initWithFrame:(CGRect)frame andTextArray:(NSArray <NSString *>*) textArray;

- (void)clickedSegmentAtIndex: (void(^)(NSUInteger index, NSString * text))index ;

@end
