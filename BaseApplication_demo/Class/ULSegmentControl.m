//
//  ULSegmentControl.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/23.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//
#define UnderLineHeight   3
#import "ULSegmentControl.h"
@interface ULSegmentControl ()

@property (strong, nonatomic) NSMutableArray<UIButton *>   *textBtnArray;

@property (strong, nonatomic) UIView   *underLineView;

@property (strong, nonatomic) UIView   *seperatView;
@property (copy, nonatomic) void(^clickHandler)(NSUInteger , NSString*);
@end

@implementation ULSegmentControl

- (instancetype)initWithFrame:(CGRect)frame andTextArray:(NSArray<NSString *> *)textArray
{
    if (self = [super initWithFrame:frame])
    {
        self.seletedIndex = 0;
        self.textColor = [UIColor darkTextColor];
        self.selectedColor = [UIColor greenColor];
        self.tintColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.textBtnArray = [NSMutableArray array];
        
        [textArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:obj forState:UIControlStateNormal];
            btn.showsTouchWhenHighlighted = YES;
            btn.tag = 412 + idx;
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self.textBtnArray addObject:btn];
            
            [self addSubview:btn];
        }];
        
        self.seperatView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.seperatView];
        self.underLineView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:self.underLineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundColor =self.tintColor;
    self.underLineView.backgroundColor = self.selectedColor;
    self.seperatView.backgroundColor =[UIColor lightGrayColor];
    self.seperatView.frame = CGRectMake(0, self.frame.size.height-0.3, self.frame.size.width, 0.3);
    [self.textBtnArray enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat width = self.width/self.textBtnArray.count;
        CGFloat height = self.height;
        obj.frame = CGRectMake(width*idx, 0, width, height);
        obj.titleLabel.font = self.textFont;
        if (self.seletedIndex == idx)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [obj setTitleColor:self.selectedColor forState:UIControlStateNormal];
                self.underLineView.frame = CGRectMake(width*idx, height-UnderLineHeight, width, UnderLineHeight);
            }];
        }
        else
        {
            [obj setTitleColor:self.textColor forState:UIControlStateNormal];
        }
    }];
}

- (void)clickBtn:(UIButton *)btn
{
    self.seletedIndex =btn.tag - 412;
    [self setNeedsLayout];
    if (self.clickHandler)
    {
        self.clickHandler(self.seletedIndex, btn.titleLabel.text);
    }
}
- (void)clickedSegmentAtIndex:(void (^)(NSUInteger, NSString *))index
{
        self.clickHandler = index;
}
@end
