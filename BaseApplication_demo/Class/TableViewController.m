//
//  TableViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData
{
    [self requestUrl];
}

#pragma mark ------------protocol --------------
- (NSString *)requestUrl
{
    return @"";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark ------------TableView_Delegate --------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        
    }
    return _tableView;
}

- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [NSMutableArray arrayWithCapacity:1];
    }
    return _items;
}
@end
