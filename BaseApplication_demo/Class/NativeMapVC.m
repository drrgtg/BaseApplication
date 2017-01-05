//
//  NativeMapVC.m
//  BaseApplication_demo
//
//  Created by FeZo on 16/12/20.
//  Copyright © 2016年 FezoLsp. All rights reserved.
//

#import "NativeMapVC.h"
#import <MapKit/MapKit.h>

#import "CLLocManager.h"
#import "ULSegmentControl.h"

@interface NativeMapVC ()
<
CLLocManagerDelegate,
MKMapViewDelegate,
UITableViewDelegate,
UITableViewDataSource
>
@property (strong, nonatomic) MKMapView   *mapView;

@property (strong, nonatomic) UITableView   *listTable;

@property (strong, nonatomic) ULSegmentControl   *segment;

@property (nonatomic) CLLocationCoordinate2D centerLocation;
//兴趣点关键字
@property (copy, nonatomic) NSString *interstStr;

@property (strong, nonatomic) NSMutableArray   *dataSourece;

@property (nonatomic) BOOL  isFinished;

@end

@implementation NativeMapVC
-(void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.interstStr = @"商务住宅";
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.listTable];
    [self.view addSubview:self.segment];
    WeakSelf
    [self.segment clickedSegmentAtIndex:^(NSUInteger index, NSString *text) {
        weakSelf.interstStr = text;
        if (index == 0)
        {
            weakSelf.interstStr = @"商务住宅";
        }
        [weakSelf searchLocationInterst:weakSelf.centerLocation andInterstStr:weakSelf.interstStr];
        
    }];
}
#pragma mark ------------ 定位当前位置动画 --------------
- (void)animationLocation:(CLLocation *)location
{
    [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.005, 0.005)) animated:YES];
    self.isFinished = YES;
}

#pragma mark ------------Lazy --------------


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
        _segment = [[ULSegmentControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/5*3, self.view.frame.size.width, 40) andTextArray:@[@"全部",@"写字楼",@"小区",@"学校"]];
        _segment.selectedColor = UIColorFromRGB(0x0085F4);
    }
    return _segment;
}
- (UITableView *)listTable
{
    if (!_listTable)
    {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width/5*3+40, self.view.frame.size.width, self.view.frame.size.height-self.view.frame.size.width/5*3-64-40) style:UITableViewStylePlain];
        _listTable.delegate = self;
        _listTable.dataSource = self;
        //        _listTable.showsHorizontalScrollIndicator = NO;
        //        _listTable.showsVerticalScrollIndicator = NO;
        
    }
    return _listTable;
}

- (MKMapView *)mapView
{
    if (!_mapView)
    {
        _mapView  = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/5*3)];
        /*
         MKMapTypeStandard = 0,//显示所有道路和一些道路名称位置的街道地图
         MKMapTypeSatellite,//显示该区域的卫星图像
         MKMapTypeHybrid,//显示道路和道路名称信息叠加在上面的区域的卫星图像
         MKMapTypeSatelliteFlyover  NS_ENUM_AVAILABLE(10_11, 9_0),
         MKMapTypeHybridFlyover     NS_ENUM_AVAILABLE(10_11, 9_0),
         */
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
        _mapView.showsScale = YES;
        //        显示建筑
        _mapView.showsBuildings = YES;
        //显示交通
        _mapView.showsTraffic = YES;
        //显示用户位置
        _mapView.showsUserLocation = YES;
    }
    return _mapView;
}
#pragma mark ------------搜索附近 --------------
/**
 搜索当前位置附近的建筑物，比如小区，大厦，学校等
 
 @param loc 地理位置
 */
-(void)searchLocationInterst:(CLLocationCoordinate2D) loc andInterstStr:(NSString *)str
{
    
    [self showLoading];
    CLLocation *currentLoc = [[CLLocation alloc] initWithLatitude:loc.latitude longitude:loc.longitude];
    
    //创建一个位置信息对象，第一个参数为经纬度，第二个为纬度检索范围，单位为米，第三个为经度检索范围，单位为米
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(loc, 3000, 3000);
    //初始化一个检索请求对象
    MKLocalSearchRequest * req = [[MKLocalSearchRequest alloc]init];
    //设置检索参数
    req.region=region;
    //兴趣点关键字
    
    req.naturalLanguageQuery= str;
    
    //初始化检索
    MKLocalSearch * ser = [[MKLocalSearch alloc]initWithRequest:req];
    //开始检索，结果返回在block中
    [ser startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        //兴趣点节点数组
        [self.dataSourece removeAllObjects];
        //距离当前位置排序
        NSArray<MKMapItem *> * addressArr =  [response.mapItems sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            MKMapItem *item1 = obj1;
            MKMapItem *item2 = obj2;
            CLLocationDistance dis1 = [currentLoc distanceFromLocation:item1.placemark.location];
            CLLocationDistance dis2 = [currentLoc distanceFromLocation:item2.placemark.location];
            return dis1 >dis2;
        }];
        //添加到dataSource中
        [addressArr enumerateObjectsUsingBlock:^(MKMapItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataSourece addObject:obj];
        }];
        //刷新tableView
        [self.listTable reloadData];
        [self hideLoading];
        
        
    }];
    
}

#pragma mark ------------TableViewDataSource --------------
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
    MKMapItem *item = self.dataSourece[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = [item.placemark.addressDictionary objectForKey:@"Thoroughfare"];
    
    
    cell.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
    return cell;
}

#pragma mark ------------TableView Delegate --------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark ------------MKMapView Delegate --------------

//动画改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
}
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
//加载地图
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    NSLog(@"%s",__FUNCTION__);
}
//加载地图失败
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    
}
//发生缩放形变
- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView
{
    NSLog(@"%s",__FUNCTION__);
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    NSLog(@"%s",__FUNCTION__);
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    NSLog(@"%s",__FUNCTION__);
    
    MKPinAnnotationView *annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MKAnnotationView"];
    annoView.pinTintColor = [UIColor orangeColor];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    leftView.backgroundColor = [UIColor greenColor];
    
    annoView.leftCalloutAccessoryView = leftView;
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    rightView.backgroundColor = [UIColor greenColor];
    annoView.rightCalloutAccessoryView = rightView;
    
    annoView.draggable = YES;
    annoView.canShowCallout = YES;
    
    return nil;
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

#if TARGET_OS_IPHONE
// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"%s",__FUNCTION__);
    
}
#endif

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"%s",__FUNCTION__);
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    NSLog(@"%s",__FUNCTION__);
    
}
//开始定位用户
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView
{
    NSLog(@"%s",__FUNCTION__);
    
}
//停止定位用户
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView
{
    NSLog(@"%s",__FUNCTION__);
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"%s",__FUNCTION__);
    
}
//定位用户失败
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"%s",__FUNCTION__);
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    NSLog(@"%s",__FUNCTION__);
    
}

#if TARGET_OS_IPHONE
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
    
}
#endif

//- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay
//{
//
//}

- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers
{
    NSLog(@"%s",__FUNCTION__);
    
}


@end
