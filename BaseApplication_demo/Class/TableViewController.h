//
//  TableViewController.h
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "CommonController.h"

@protocol TableViewProtocol <NSObject>

@required
- (NSString *)requestUrl;


@end

@interface TableViewController : CommonController
<
UITableViewDelegate,
UITableViewDataSource,
TableViewProtocol
>

@property (strong, nonatomic) UITableView   *tableView;
@property (strong, nonatomic) NSMutableArray   *items;

@end
