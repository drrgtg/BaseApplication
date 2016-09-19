//
//  RetryButton.m
//  SBookshop
//
//  Created by seamine on 15/12/23.
//  Copyright © 2015年 evolt. All rights reserved.
//

#import "RetryButton.h"

@implementation RetryButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderColor = [[UIColor colorWithWhite:0.75f alpha:1.0f] CGColor];
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 5.0f;
        self.backgroundColor = [UIColor whiteColor];
        
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.labelTitle.text = @"重新加载";
        self.labelTitle.textAlignment = NSTextAlignmentCenter;
        self.labelTitle.textColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
        [self addSubview:self.labelTitle];
        
        [self addTarget:self action:@selector(onTouchDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(onTouchUp) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    }
    return self;
}

- (void)onTouchDown
{
    self.backgroundColor = [UIColor colorWithWhite:0.75f alpha:1.0f];
}

- (void)onTouchUp
{
    self.backgroundColor = [UIColor whiteColor];
}

@end
