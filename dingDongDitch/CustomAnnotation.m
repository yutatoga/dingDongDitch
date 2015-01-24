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

- (NSString *)title {
	return annotationTitle;
}

- (NSString *)subtitle {
	return annotationSubtitle;
}

- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
													 title:(NSString *)_annotationTitle subtitle:(NSString *)_annotationSubtitle {
	coordinate = _coordinate;
	self.annotationTitle = _annotationTitle;
	self.annotationSubtitle = _annotationSubtitle;
	return self;
}

@end