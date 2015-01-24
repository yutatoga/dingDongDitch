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
	mapView.delegate = self;
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
	coordinateRegion.span.latitudeDelta = 0.005;
	coordinateRegion.span.longitudeDelta = 0.005;
	[mapView setRegion:coordinateRegion animated:NO];
	[self.view addSubview:mapView];
	
	// call method per one sec
	// NSTimer *tm = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loopMethod:) userInfo:nil repeats:YES];
	
	[mapView addAnnotation:
	 [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.656281,139.694568)
																									title:@"50Point"
																							 subtitle:@"Sato's house"]];
}

-(void)loopMethod:(NSTimer*)timer{
	NSLog(@"loopMethod");
	[self sendGPS:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
}

-(void)sendGPS:(double)latitude longitude:(double)longitude{
	NSURL *loginUrl = [NSURL URLWithString:@"http://172.16.42.52:3000/gps"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	[request setHTTPMethod:@"POST"];
	NSString *postString = [NSString stringWithFormat:@"latitude=%f&longitude=%f",latitude,longitude];
	[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"RETURNED:%@",returnString);
}

- (void)locationManager:(CLLocationManager *)manager
		didUpdateToLocation:(CLLocation *)newLocation
					 fromLocation:(CLLocation *)oldLocation{
	NSLog(@"sweet");
	// 位置情報取得
	currentLocation = newLocation;
	[mapView setCenterCoordinate:newLocation.coordinate animated:YES];
//	// ロケーションマネージャ停止
//	[locationManager stopUpdatingLocation];
}

-(MKAnnotationView*)mapView:(MKMapView*)mapView
					viewForAnnotation:(id <MKAnnotation>)annotation {
	if (annotation == mapView.userLocation) { //……【2】
		return nil;
	} else {
		CustomAnnotationView *annotationView;
		NSString* identifier = @"customAnnotation"; // 再利用時の識別子
		
		// 再利用可能な MKAnnotationView を取得
		annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
		
		if(nil == annotationView) {
			//再利用可能な MKAnnotationView がなければ新規作成
			annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
		}
		annotationView.annotation = annotation;
		return annotationView;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
