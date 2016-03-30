//
//  LocationVC.m
//  ChuanSongMen
//
//  Created by apple on 16/3/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LocationVC.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AddressInfoCell.h"
@interface LocationVC ()<CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@property (nonatomic, strong) CLLocationManager *locationManager;


@end

@implementation LocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
   self.titleLable.text = @"位置信息";
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressInfoCell" bundle:nil] forCellReuseIdentifier:@"addressCell"];
    _tableView.rowHeight = 51;
    [self changeLayerOfSomeControl:self.topView];
    
}

- (void)mapLoca{
    
    if (![CLLocationManager locationServicesEnabled]||[CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    //设置代理
    self.locationManager.delegate = self;
    //设置定位精度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //定位频率,每隔多少米定位一次
    CLLocationDistance distance = 10.0;//十米定位一次
    self.locationManager.distanceFilter = distance;
    //启动跟踪定位
    [self.locationManager startUpdatingLocation];
    //定位
    [self.locationManager requestAlwaysAuthorization];
    [self.locationManager startUpdatingLocation];
    //用户位置追踪(用户位置追踪用于标记用户当前位置，此时会调用定位服务)
    _mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    //设置地图类型
    _mapView.mapType = MKMapTypeStandard;
    //添加大头针
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressCell"];
    
    return cell;
}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
