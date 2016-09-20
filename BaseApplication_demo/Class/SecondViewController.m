//
//  SecondViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/9/13.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "SecondViewController.h"
#import "CoreData.h"
@interface SecondViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic)  UITextField *name;
@property (strong, nonatomic)  UITextField *telephone;
@property (strong, nonatomic) UIButton   *btn;

@property (strong, nonatomic) UITableView   *tableView;

@property (strong, nonatomic) NSArray   *dataSource;

@property (nonatomic, strong) CoreData   * coreData;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor  = [UIColor greenColor];
    
    
    self.coreData = [CoreData defaultCoreData];
    
    self.name = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 40)];
    self.name.borderStyle = UITextBorderStyleRoundedRect;
    self.name.placeholder = @"name";
    self.telephone = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 100, 40)];
    self.telephone.borderStyle = UITextBorderStyleRoundedRect;
    self.telephone.placeholder = @"telephone";
    self.btn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.btn.frame=CGRectMake(100, 300, 40, 40);
    
    [self.btn setTitle:@"存" forState:UIControlStateNormal];
    [self.btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    UIButton *seaBtn  = [UIButton buttonWithType:UIButtonTypeSystem];
    seaBtn.frame = CGRectMake(200, 300, 40, 40);
    [seaBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [seaBtn addTarget:self action:@selector(clickSear) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seaBtn];
    UIButton *seaBtn2  = [UIButton buttonWithType:UIButtonTypeSystem];
    seaBtn2.frame = CGRectMake(300, 300, 40, 40);
    [seaBtn2 setTitle:@"删除" forState:UIControlStateNormal];
    [seaBtn2 addTarget:self action:@selector(deleteData) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:seaBtn2];
    [self.view addSubview:self.name];
    [self.view addSubview:self.telephone];
    [self.view addSubview:self.btn];
    
    [self.view addSubview:self.tableView];

}
- (void)deleteData
{
    BOOL suc = [self.coreData removeAllData];
    NSLog(@"%d",suc);
    self.dataSource = [self.coreData searchAllData];
    
    [self.tableView reloadData];
}
- (void)click{
    
    BOOL suc = [self.coreData insertObjName:self.name.text andTel:self.telephone.text];
    
    NSLog(@"%d..%@",suc,[self.coreData applicationDocumentsDirectory]);
    self.dataSource = [self.coreData searchAllData];
    
    [self.tableView reloadData];
}
- (void)clickSear{
    
    self.dataSource = [self.coreData searchAllData];
    
    [self.tableView reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCellId =@"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCellId];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    Entity1 *ent = [self.dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = ent.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",ent.telephone];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


-(UITableView *)tableView{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 340, SCREEN_WIDTH, self.view.height-340-49-64) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor orangeColor];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
