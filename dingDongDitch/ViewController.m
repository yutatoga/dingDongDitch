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
	mapView.frame = CGRectMake(0, 95, self.view.frame.size.width, self.view.frame.size.height-95);
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
//	NSTimer *tm = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(loopMethod:) userInfo:nil repeats:YES];
//	NSTimer *tm2 = [NSTimer scheduledTimerWithTimeInterval:15.0f target:self selector:@selector(showLoseResultView) userInfo:nil repeats:false];
//	NSTimer *tm3 = [NSTimer scheduledTimerWithTimeInterval:25.0f target:self selector:@selector(showWinResultView) userInfo:nil repeats:false];
	
	[mapView addAnnotation:
	 [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.656281,139.694568)
																								 title:@"Sato's house"
																							subtitle:@""
																								 point:42]];
	
	[mapView addAnnotation:
	 [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.654515,139.695319)
																								 title:@"John's house"
																							subtitle:@""
																								 point:42]];
	
	[mapView addAnnotation:
	 [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.657763,139.695083)
																								 title:@"Kato's house"
																							subtitle:@""
																								 point:42]];
	
	[mapView addAnnotation:
	 [[CustomAnnotation alloc]initWithLocationCoordinate:CLLocationCoordinate2DMake(35.657144,139.69732)
																								 title:@"Yuta's house"
																							subtitle:@""
																								 point:42]];
	
	//user status view
	userStatusImageView = [[UIImageView alloc] init];
	[userStatusImageView setFrame:self.view.frame];
	userStatusImage = [UIImage imageNamed:@"header.png"];
	[userStatusImageView setImage:userStatusImage];
	[self.view addSubview:userStatusImageView];
	
	// debug button
	// - show lose button (left side)
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	winOrLose = false;
	[button setFrame:CGRectMake(0, 0, 100, 100)];
	[button addTarget:self action:@selector(showLoseResultView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];
	// - show win button (right side)
	UIButton *buttonForWin = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[buttonForWin setFrame:CGRectMake(self.view.frame.size.width-100, 0, 100, 100)];
	[buttonForWin addTarget:self action:@selector(showWinResultView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:buttonForWin];
}

-(void)loopMethod:(NSTimer*)timer{
	NSLog(@"loopMethod");
//	[self sendGPS:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
//	[self getResult:currentLocation.coordinate.latitude longitude:currentLocation.coordinate.longitude];
}

-(void)sendGPS:(double)latitude longitude:(double)longitude{
	NSURL *loginUrl = [NSURL URLWithString:@"http://172.16.42.68/gps"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	
	[request setHTTPMethod:@"POST"];
	NSString *postString = [NSString stringWithFormat:@"latitude=%f&longitude=%f",latitude,longitude];
	[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"sendGPS - RETURNED:%@",returnString);
}

-(void)getResult:(double)latitude longitude:(double)longitude{
	NSLog(@"getResult");
	NSURL *loginUrl = [NSURL URLWithString:@"http://172.16.42.68/result"];
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginUrl cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5.0];
	
	[request setHTTPMethod:@"POST"];
	NSString *postString = [NSString stringWithFormat:@"latitude=%f&longitude=%f",latitude,longitude];
	[request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
	
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
	NSLog(@"getResult - RETURNED:%@",returnString);
	
	NSArray* values = [returnString componentsSeparatedByString:@","];
	NSLog(@"%@", values);
	if ([values[0] isEqualToString:@"-1"]) {
		NSLog(@"do nothing");
	}else{
		NSLog(@"judge");
	}
}

- (void)locationManager:(CLLocationManager *)manager
		didUpdateToLocation:(CLLocation *)newLocation
					 fromLocation:(CLLocation *)oldLocation{
	NSLog(@"locationManager - didUpdateToLocation");
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
			
			// not working below
			// annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier point:[annotation point]];
			// random
			int n = arc4random() % 3;
			switch (n) {
				case 0:
					annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier point:50];
					break;
				case 1:
					annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier point:100];
					break;
				case 2:
					annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier point:500];
					break;
				default:
					break;
			}
		}
		annotationView.annotation = annotation;
		return annotationView;
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(void)showLoseResultView{
	ResultViewController *resultViewController;
	resultViewController = [[ResultViewController alloc] init];
	[resultViewController updateResultView:false];
	[self presentViewController:resultViewController animated:YES completion:nil];
}

-(void)showWinResultView{
	ResultViewController *resultViewController;
	resultViewController = [[ResultViewController alloc] init];
	[resultViewController updateResultView:true];
	[self presentViewController:resultViewController animated:YES completion:nil];
}

@end
