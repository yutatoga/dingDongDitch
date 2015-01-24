//
//  ViewController.h
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CustomAnnotation.h"
#import "CustomAnnotationView.h"
@interface ViewController : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
	CLLocationManager* locationManager;
	MKMapView *mapView;
	CLLocation *currentLocation;
	UIImageView *userStatusImageView;
	UIImage *userStatusImage;
}


@end

