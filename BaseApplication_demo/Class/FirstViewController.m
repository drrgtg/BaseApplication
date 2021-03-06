//
//  FirstViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "FirstViewController.h"

#import "NativeMapVC.h"
#import "WkWebViewController.h"
#import "QRCodeViewController.h"
#import "ELMMapViewController.h"


#define FIRST_TABLE_CELL_ID     @"FIRST_TABLE_CELL_ID"

@interface FirstViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>


@property (strong, nonatomic) UITableView   *tableView;
@property (strong, nonatomic) NSMutableArray   *dataSouce;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor orangeColor];

    
    [self.view addSubview:self.tableView];
    
}
#pragma mark ------------dataSource --------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSouce.count;
}
#pragma mark ------------delegate --------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FIRST_TABLE_CELL_ID forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:FIRST_TABLE_CELL_ID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.dataSouce[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonController *pushVC = nil;

    switch (indexPath.row)
    {
        case 0:
        {
            NativeMapVC *vc = [[NativeMapVC alloc] init];
            pushVC = vc;
        }
        break;
        case 1:
        {
            WkWebViewController *vc = [[WkWebViewController alloc] init];
            pushVC = vc;

        }
        break;
        case 2:
        {
            QRCodeViewController *vc = [[QRCodeViewController alloc] init];
            pushVC = vc;
        }
            break;
        case 3:
        {
            ELMMapViewController *vc = [[ELMMapViewController alloc] init];
            pushVC= vc;
        }
        default:
        break;
    }
    
    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------------lazy --------------
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:FIRST_TABLE_CELL_ID];
    }
    return _tableView;
}
- (NSMutableArray *)dataSouce
{
    if (!_dataSouce)
    {
        _dataSouce = [NSMutableArray arrayWithObjects:
                      @"原生地图(高仿饿了么)",
                      @"WKWeb",
                      @"二维码",
                      @"高德地图(高仿饿了么)",nil];
    }
    return _dataSouce;
}
@end
