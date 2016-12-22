//
//  CLLocManager.h
//  SBookshop
//
//  Created by FeZo on 16/11/4.
//  Copyright © 2016年 evolt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CLLocManagerDelegate <NSObject>

@optional

- (void)locationWithLoc:(CLLocation *) cllocation;

@end
@interface CLLocManager : NSObject

@property (weak, nonatomic)id<CLLocManagerDelegate> delegate;

+ (instancetype)shareLocationManager;

- (void)startLocation;


@end
