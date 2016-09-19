//
//  RetryView.h
//  SBookshop
//
//  Created by seamine on 15/12/23.
//  Copyright © 2015年 evolt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RetryButton.h"

@interface RetryView : UIView

@property (strong, nonatomic) UIImageView *netErrorImageView;

@property (strong, nonatomic) UILabel *labelInfo1;
@property (strong, nonatomic) UILabel *labelInfo2;

@property (strong, nonatomic) RetryButton *buttonRetry;

@end
