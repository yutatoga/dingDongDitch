//
//  CustomAnnotation.m
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import "CustomAnnotation.h"

@implementation CustomAnnotation
@synthesize coordinate;
@synthesize annotationTitle;
@synthesize annotationSubtitle;
@synthesize point;

- (NSString *)title {
	return annotationTitle;
}

- (NSString *)subtitle {
	return annotationSubtitle;
}

- (int) point{
	return point;
}

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
													 title:(NSString *)_annotationTitle
												subtitle:(NSString *)_annotationSubtitle
													 point:(int)_point{
	coordinate = _coordinate;
	self.annotationTitle = _annotationTitle;
	self.annotationSubtitle = _annotationSubtitle;
	self.point = _point;
	return self;
}

@end