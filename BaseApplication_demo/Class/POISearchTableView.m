//
//  POISearchTableView.m
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/3.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import "POISearchTableView.h"
#define POISearchCellID     @"cellid1"

@interface POISearchTableView ()
<UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView   *searchTableView;
@property (strong, nonatomic) UILabel   *footLab;
@end

@implementation POISearchTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame])
    {
        self.searchTableView = [[UITableView alloc] initWithFrame:self.bounds style:style];
        self.searchTableView.backgroundColor = [UIColor clearColor];
        self.searchTableView.delegate = self;
        self.searchTableView.dataSource = self;
        self.searchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        self.dataItems = [NSMutableArray arrayWithCapacity:0];
        
        [self addSubview:self.searchTableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
- (void)reloadData
{
    if (self.dataItems.count>0)
    {
        self.searchTableView.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        self.searchTableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];

    }
    [self.searchTableView reloadData];
}
- (UILabel *)footLab
{
    if (!_footLab)
    {
        UILabel *lab =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 100)];
        lab.textColor = [UIColor darkTextColor];
        lab.text = @"找不到地址?\n请尝试只输入小区、写字楼或学校名，\n详细地址（如门牌号）可稍后输入哦。\n";
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:15];
        _footLab = lab;
    }
    return _footLab;
}
#pragma mark ------------dataSouce --------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.dataItems.count>0)
    {
        return 100.0;
    }
    else{
        return 0.01;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}
#pragma mark ------------delegate --------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:POISearchCellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:POISearchCellID];
    }
    AMapTip *item = self.dataItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@",item.district, item.address];
    
    cell.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.dataItems.count)
    {
        return self.footLab;
    }
    else
    {
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapTip *item = self.dataItems[indexPath.row];
    NSLog(@"%@",item.address);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
