//
//  CustomAnnotation.h
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface CustomAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	NSString *annotationTitle;
	NSString *annotationSubtitle;
	int point;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) NSString *annotationTitle;
@property (nonatomic, retain) NSString *annotationSubtitle;
@property (nonatomic , assign) int point;
- (id)initWithLocationCoordinate:(CLLocationCoordinate2D) _coordinate
													 title:(NSString *)_annotationTitle
												subtitle:(NSString *)_annotationannSubtitle
													 point:(int)_point;
- (NSString *)title;
- (NSString *)subtitle;
- (int) point;

@end
