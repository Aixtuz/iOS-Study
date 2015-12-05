//
//  ReverceGeocoderViewController.m
//  02-Geocoder
//
//  Created by Aixtuz Kang on 15/8/15.
//  Copyright © 2015年 Aixtuz Kang. All rights reserved.
//

#import "ReverceGeocoderViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ReverceGeocoderViewController ()

// 维度
@property (weak, nonatomic) IBOutlet UITextField *latitudeTF;
// 经度
@property (weak, nonatomic) IBOutlet UITextField *longitudeTF;
// 城市
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;


@end

@implementation ReverceGeocoderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 反地理编码
- (IBAction)reverseGeocoderClick:(UIButton *)sender {
    
    // 经纬度存空, 直接返回
    if (self.latitudeTF.text.length == 0 || self.longitudeTF.text.length == 0) {
        return;
    }
    
    // 创建地理编码对象
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    // 根据经纬度创建位置对象, 经纬度: Double
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.latitudeTF.text.doubleValue longitude:self.longitudeTF.text.doubleValue];
    
    // 调用方法
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        //2.1 防错处理
        if (placemarks.count == 0 || error) {
            NSLog(@"无值/有错");
            return;
        }
        
        // 遍历地标对象数组
        for (CLPlacemark *placemark in placemarks) {
            
            // 城市有值返回, 无则返回行政区域
            if (placemark.locality) {
                self.cityLabel.text = placemark.locality;
            } else {
                self.cityLabel.text = placemark.administrativeArea;
            }
        }
    }];
}

@end

