//
//  RetryView.m
//  SBookshop
//
//  Created by seamine on 15/12/23.
//  Copyright © 2015年 evolt. All rights reserved.
//

#import "RetryView.h"

@implementation RetryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat topOffset = self.frame.size.height/2-32;
        
        self.netErrorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"net_error.png"]];
        self.netErrorImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/4);
        [self addSubview:self.netErrorImageView];
        
        self.labelInfo1 = [[UILabel alloc] initWithFrame:CGRectMake(0, topOffset, self.frame.size.width, 20)];
        self.labelInfo1.text = @"网络请求失败";
        self.labelInfo1.textColor = [UIColor grayColor];
        self.labelInfo1.textAlignment = NSTextAlignmentCenter;
        self.labelInfo1.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:self.labelInfo1];
        topOffset += 25;
        
        self.labelInfo2 = [[UILabel alloc] initWithFrame:CGRectMake(0, topOffset, self.frame.size.width, 20)];
        self.labelInfo2.text = @"请检查网络";
        self.labelInfo2.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        self.labelInfo2.textAlignment = NSTextAlignmentCenter;
        self.labelInfo2.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:self.labelInfo2];
        topOffset += 25;
        
        self.buttonRetry = [[RetryButton alloc] initWithFrame:CGRectMake(5, topOffset, self.frame.size.width-10, 35)];
        [self addSubview:self.buttonRetry];
    }
    return self;
}

@end
