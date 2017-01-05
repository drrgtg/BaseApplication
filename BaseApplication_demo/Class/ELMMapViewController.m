//
//  ELMMapViewController.m
//  BaseApplication_demo
//
//  Created by FeZo on 17/1/3.
//  Copyright © 2017年 FezoLsp. All rights reserved.
//

#import "ELMMapViewController.h"

#import <MapKit/MapKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

#import "MapSearchBar.h"
#import "POISearchTableView.h"
#import "ULSegmentControl.h"


@interface ELMMapViewController ()
<
MKMapViewDelegate,
UISearchBarDelegate,
UITableViewDataSource,
UITableViewDelegate,
AMapSearchDelegate
>

@property (strong, nonatomic) MapSearchBar   *searchBar;

@property (strong, nonatomic) MKMapView   *mapView;

@property (nonatomic) CLLocationCoordinate2D centerLocation;

@property (strong, nonatomic) ULSegmentControl   *segment;
@property (strong, nonatomic) UITableView   *listTable;
@property (strong, nonatomic) NSMutableArray   *dataSourece;
@property (strong, nonatomic) AMapSearchAPI   *search;
@property (copy, nonatomic) NSString *interstStr;

@property (nonatomic) BOOL  isFinished;



@property (strong, nonatomic) POISearchTableView   *searchTableView;
@end

@implementation ELMMapViewController
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        self.navigationItem.titleView  = self.searchBar;
        ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
        [AMapServices sharedServices].apiKey = GDMPKEY;
        [AMapServices sharedServices].enableHTTPS = YES;
        
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
        ///初始化地图
        self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/5*3.2)];
        
        UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingweiELM"]];
        imgV.frame = CGRectMake(0, 0, 42, 60);
        imgV.contentMode = UIViewContentModeTop;
        imgV.center = CGPointMake(self.mapView.center.x-0.5, self.mapView.center.y);
        [self.mapView addSubview:imgV];
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(15, self.mapView.frame.size.height-50, 30, 30);
        [leftBtn setImage:[UIImage imageNamed:@"location_g"] forState:UIControlStateNormal];
        leftBtn.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.7];
        leftBtn.layer.cornerRadius =5;
        leftBtn.layer.masksToBounds = YES;
        [self.mapView addSubview:leftBtn];
        [leftBtn addTarget:self action:@selector(backToUserLocation) forControlEvents:UIControlEventTouchUpInside];
        //地图类型
        _mapView.mapType = MKMapTypeStandard;
        //代理
        _mapView.delegate = self;
        //        //允许缩放
        _mapView.zoomEnabled = YES;
        //        //允许3D效果
        _mapView.pitchEnabled = YES;
        //        //旋转允许
        _mapView.rotateEnabled = YES;
        //        //滑动允许
        _mapView.scrollEnabled = YES;
        //显示指南针
        _mapView.showsCompass = YES;
        //显示兴趣点
        _mapView.showsPointsOfInterest = YES;
        //显示比例
//        _mapView.showsScale = YES;
        //        显示建筑
        _mapView.showsBuildings = YES;
        //显示交通
        _mapView.showsTraffic = YES;
        //显示用户位置
        _mapView.showsUserLocation = YES;
        
        [self.view addSubview:self.searchTableView];

        ///把地图添加至view
        [self.view addSubview:self.mapView];
        [self.view addSubview:self.segment];
        [self.view addSubview:self.listTable];

        self.interstStr = @"商务住宅";

        WeakSelf
        [self.segment clickedSegmentAtIndex:^(NSUInteger index, NSString *text) {
            weakSelf.interstStr = text;
            if (index == 0)
            {
                weakSelf.interstStr = @"商务住宅";
            }
            [weakSelf.listTable setContentOffset:CGPointMake(0, 0) animated:YES];
            [weakSelf searchLocationInterst:weakSelf.centerLocation andInterstStr:weakSelf.interstStr];
            
        }];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark ------------private method --------------
- (void)backToUserLocation
{
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
}
#pragma mark ------------ 定位当前位置动画 --------------
- (void)animationLocation:(CLLocation *)location
{
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.005, 0.005)) animated:YES];
    self.isFinished = YES;
}
#pragma mark ------------搜索附近 --------------
/**
 搜索当前位置附近的建筑物，比如小区，大厦，学校等
 
 @param loc 地理位置
 */
-(void)searchLocationInterst:(CLLocationCoordinate2D) loc andInterstStr:(NSString *)str
{
    [self showLoading];
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:loc.latitude longitude:loc.longitude];
    request.keywords            = self.interstStr;
    /* 按照距离排序. */
    request.sortrule            = 0;
//    request.requireExtension    = YES;
    [self.search AMapPOIAroundSearch:request];
    
}
#pragma mark ------------关键字搜索 --------------
- (void)searchTipsWithKey:(NSString *)key
{
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];

    
    tips.keywords = key;
    //城市选择默认选中当前城市，不能设置限制城市功能，否则搜索其他城市地名无法出现。
    tips.types = @"商务住宅";
    tips.city = @"长沙";
    
    [self.search AMapInputTipsSearch:tips];
}
#pragma mark ------------lazy --------------
- (MapSearchBar *)searchBar
{
    if (!_searchBar)
    {
        _searchBar = [[MapSearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}
- (NSMutableArray *)dataSourece
{
    if (!_dataSourece)
    {
        _dataSourece = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourece;
}
- (ULSegmentControl *)segment
{
    if (!_segment)
    {
        _segment = [[ULSegmentControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/5*3.2, self.view.frame.size.width, 40) andTextArray:@[@"全部",@"写字楼",@"小区",@"学校"]];
        _segment.selectedColor = UIColorFromRGB(0x0085F4);
    }
    return _segment;
}
- (UITableView *)listTable
{
    if (!_listTable)
    {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/5*3.2+40, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.width/5*3.2-64-40) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
    }
    return _listTable;
}
- (POISearchTableView *)searchTableView
{
    if (!_searchTableView)
    {
        _searchTableView = [[POISearchTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
        _searchTableView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.4];
    }
    return _searchTableView;
}


#pragma mark ------------SearchBar delegate --------------
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    // return NO to not become first responder
    searchBar.showsCancelButton = YES;
    [self.searchTableView.dataItems removeAllObjects];
    [self.searchTableView reloadData];
    [self.view bringSubviewToFront:self.searchTableView];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    searchBar.showsCancelButton = NO;
    return YES;
    // return NO to not resign first responder
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar __TVOS_PROHIBITED   // called when cancel button pressed
{
    [searchBar resignFirstResponder];
    [self.view sendSubviewToBack:self.searchTableView];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    [searchBar resignFirstResponder];
}
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text NS_AVAILABLE_IOS(3_0)
{
    [self searchTipsWithKey:searchBar.text];
    return YES;
}
#pragma mark ------------MKMapView Delegate --------------

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
    NSLog(@"%f,%f",mapView.centerCoordinate.longitude,mapView.centerCoordinate.latitude);
    self.centerLocation = mapView.centerCoordinate;
    //当用户拖拽完成的时候根据中心点来自动搜索附近兴趣点。比如小区，写字楼，学校，全部等等.
    if (self.isFinished) {
        [self searchLocationInterst:self.centerLocation andInterstStr:self.interstStr];
    }
    
}

//加载地图失败
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    
}
// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    NSLog(@"%s",__FUNCTION__);
    //在显示用户点之后进行缩放动画以及定位位置。。。
    if (!self.isFinished)
    {
        [self animationLocation:mapView.userLocation.location];
    }
}
#pragma mark ------------AMapSearchAPI delegate --------------
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }
    
    //解析response获取POI信息，具体解析见 Demo
    self.dataSourece = [NSMutableArray arrayWithArray:response.pois];
    
    [self.listTable reloadData];
    [self hideLoading];
    
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"%s: searchRequest = %@, errInfo= %@", __func__, [request class], error);
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    [self.searchTableView.dataItems removeAllObjects];
    [response.tips enumerateObjectsUsingBlock:^(AMapTip * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.uid.length>1)
        {
            [self.searchTableView.dataItems addObject:obj];
        }
    }];
    [self.searchTableView reloadData];
}
#pragma mark ------------tableView dataSource & delegate --------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSourece.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"dingweiId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.imageView.image = [UIImage imageNamed:@"weizhi"];
    cell.imageView.contentMode = UIViewContentModeTop;
    
    AMapPOI *item = self.dataSourece[indexPath.row];
    
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.address;
    cell.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
