//
//  ViewController.m
//  01-CoreLocation
//
//  Created by Aixtuz Kang on 15/8/15.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

// 位置管理器
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 创建位置管理器
    self.locationManager = [[CLLocationManager alloc] init];
    
    // 设置VC做管理器的代理
    self.locationManager.delegate = self;
    
    // 版本 >= 8.0 才需授权
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {

        // 用时授权
        [self.locationManager requestWhenInUseAuthorization];
        // 始终授权
        [self.locationManager requestAlwaysAuthorization];
        
        // iOS 9 新特性: 后台定位
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    // 距离筛选器: 持续定位, 达到偏移, 调用代理方法
    self.locationManager.distanceFilter = 50;
    
    // 定位精准度: 误差范围内视为同一点
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    // 开始更新位置
    [self.locationManager startUpdatingLocation];
    
    // 计算距离
    [self compareDistance];
}

// 计算 Distance
- (void)compareDistance {
    
    // 北京 vs 西安
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:40.06 longitude:116.39];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:34.27 longitude:108.93];
    
    // 计算
    CGFloat distance = [loc1 distanceFromLocation:loc2];
    NSLog(@"\n经度: %f, 维度: %f\n和\n经度: %f, 维度: %f\n相距: %f", loc1.coordinate.longitude, loc1.coordinate.latitude, loc2.coordinate.longitude, loc2.coordinate.latitude, distance);
}

// 更新位置方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    // CLLocation对象属性: coordinate: longitude,经度; latitude,维度;
    CLLocation *location = [locations lastObject];
    NSLog(@"经度:%f, 维度:%f", location.coordinate.longitude, location.coordinate.latitude);
    
    // 停止更新位置
    [self.locationManager stopUpdatingLocation];
}

@end

