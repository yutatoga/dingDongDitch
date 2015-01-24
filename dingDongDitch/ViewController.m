//
//  ViewController.m
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	[locationManager startUpdatingLocation];
	locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	if( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ) {
		NSLog(@"cattt");
		// iOS8の場合は、以下の何れかの処理を追加しないと位置の取得ができない
		// アプリがアクティブな場合だけ位置取得する場合
		// [locationManager requestWhenInUseAuthorization];
		// アプリが非アクティブな場合でも位置取得する場合
		[locationManager requestAlwaysAuthorization];
	}
	if([CLLocationManager locationServicesEnabled]){
		// 位置情報取得開始
		[locationManager startUpdatingLocation];
	}else{
		// 位置取得が許可されていない場合
		NSLog(@"foobar!!");
	}
	
	// map setting
	mapView = [[MKMapView alloc] init];
	mapView.showsUserLocation = YES;
	mapView.mapType = MKMapTypeSatellite;
	mapView.frame = 	self.view.frame;
	// - coordinate setting
	CLLocationCoordinate2D coordinate;
	coordinate.latitude = 35.68664111;
	coordinate.longitude = 139.6948839;
	[mapView setCenterCoordinate:coordinate animated:NO];
	// - region setting
	MKCoordinateRegion coordinateRegion = mapView.region;
	coordinateRegion.center = coordinate;
	coordinateRegion.span.latitudeDelta = 0.01;
	coordinateRegion.span.longitudeDelta = 0.01;
	[mapView setRegion:coordinateRegion animated:NO];
	[self.view addSubview:mapView];
}


- (void)locationManager:(CLLocationManager *)manager
		didUpdateToLocation:(CLLocation *)newLocation
					 fromLocation:(CLLocation *)oldLocation{
	NSLog(@"sweet");
	// 位置情報取得
	[mapView setCenterCoordinate:newLocation.coordinate animated:YES];
//	// ロケーションマネージャ停止
//	[locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
