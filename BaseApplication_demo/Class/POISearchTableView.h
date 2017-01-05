//
//  POISearchTableView.h
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/3.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

@interface POISearchTableView : UIView

@property (strong, nonatomic) NSMutableArray   *dataItems;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)reloadData;
@end
