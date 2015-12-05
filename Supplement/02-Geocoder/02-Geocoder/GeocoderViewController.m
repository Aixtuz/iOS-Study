//
//  GeocoderViewController.m
//  02-Geocoder
//
//  Created by Aixtuz Kang on 15/8/15.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "GeocoderViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface GeocoderViewController ()

// 地址输入框
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
// 维度
@property (weak, nonatomic) IBOutlet UILabel *lagitudeLabel;
// 经度
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
// 详细地址
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;


@end

@implementation GeocoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 地理编码
- (IBAction)geocoderClick:(UIButton *)sender {
    
    // 字符为空, 直接返回
    if (self.addressTF.text.length == 0) {
        return;
    }
    
    // 创建编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // 执行方法
    [geocoder geocodeAddressString:self.addressTF.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        // 无值/有错, 直接返回
        if (placemarks.count == 0 || error) {
            NSLog(@"无值/有错");
            return;
        }
        
        // 遍历地标对象数组
        for (CLPlacemark *placemark in placemarks) {
            
//            // 获取城市
//            if (placemark.locality) {
//                NSLog(@"city: %@", placemark.locality);
//            } else {
//                NSLog(@"city: %@", placemark.administrativeArea);
//            }
            
            // 获取详细地址
            self.detailAddressLabel.text = placemark.name;
            
            // 获取经纬度
            self.lagitudeLabel.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.latitude];
            self.longitudeLabel.text = [NSString stringWithFormat:@"%f", placemark.location.coordinate.longitude];
            
//            NSLog(@"latitude: %f, longitude: %f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude);
        }
    }];
}


@end

