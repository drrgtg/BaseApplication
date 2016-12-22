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

@interface NativeMapVC ()
<
CLLocManagerDelegate,
MKMapViewDelegate
>
@property (strong, nonatomic) MKMapView   *mapView;

@property (nonatomic) CLLocation *centerLocation;

@end

@implementation NativeMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mapView];
    CLLocManager *man = [CLLocManager shareLocationManager];
    
    man.delegate = self;
    [man startLocation];
}

-(void)locationWithLoc:(CLLocation *)cllocation
{
    self.centerLocation = cllocation;
}



- (void)setCenterCoordinate:(CLLocationCoordinate2D)coordinate animated:(BOOL)animated
{
    
}
#pragma mark ------------ 定位当前位置动画 --------------
- (void)animationLocation
{
    [self.mapView setCenterCoordinate:self.centerLocation.coordinate animated:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(self.centerLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
}

#pragma mark ------------Lazy --------------
- (MKMapView *)mapView
{
    if (!_mapView)
    {
        _mapView  = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width/4*3)];
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


#pragma mark ------------MKMapView Delegate --------------

//动画改变
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"%s",__FUNCTION__);

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

    return nil;
}

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views
{
    NSLog(@"%s",__FUNCTION__);
    //在显示用户点之后进行缩放动画以及定位位置。。。
    [self animationLocation];
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
