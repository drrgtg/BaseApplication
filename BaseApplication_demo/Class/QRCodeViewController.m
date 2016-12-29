//
//  QRCodeViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/24.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "QRCodeViewController.h"
#import "ScanViewController.h"
#import "DiscoverViewController.h"
#define QRCODECELLID  @"QRCODECELLID"
@interface QRCodeViewController ()

@end

@implementation QRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.items = [NSMutableArray arrayWithObjects:@"二维码扫描",@"二维码识别", nil];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------------dataSource --------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}
#pragma mark ------------delegate --------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QRCODECELLID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:QRCODECELLID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.items[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommonController *pushVC = nil;
    switch (indexPath.row)
    {
        case 0:
        {
            ScanViewController *vc = [[ScanViewController alloc] init];
            pushVC = vc;
        }
            break;
        case 1:
        {
            DiscoverViewController *vc = [[DiscoverViewController alloc] init];
            pushVC = vc;
            
        }
            break;
        default:
            break;
    }
    
//    pushVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
