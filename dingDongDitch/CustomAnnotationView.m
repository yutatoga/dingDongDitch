//
//  CustomAnnotationView.m
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation
				 reuseIdentifier:(NSString *)reuseIdentifier
									 point:(int) point{
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	switch (point) {
  case 50:
			self.image = [UIImage imageNamed:@"customAnnotation_50.png"];
			break;
	case 100:
			self.image = [UIImage imageNamed:@"customAnnotation_100.png"];
			break;
	case 500:
			self.image = [UIImage imageNamed:@"customAnnotation_500.png"];
			break;
  default:
			break;
	}
	self.canShowCallout = true;
	return self;
}



@end
