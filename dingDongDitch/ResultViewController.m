//
//  ResultViewController.m
//  dingDongDitch
//
//  Created by SystemTOGA on 2015/01/24.
//  Copyright (c) 2015年 Yuta Toga. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

	
}

- (void)updateResultView: (bool)winOrLose{
	UIImageView *resultImageView = [[UIImageView alloc] init];
	[resultImageView setFrame:self.view.frame];
	if (winOrLose) {
		resultImageView.image = [UIImage imageNamed:@"win.png"];
	}else{
		resultImageView.image = [UIImage imageNamed:@"lose.png"];
	}
	[self.view addSubview:resultImageView];
	
	// x button
	UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[button setFrame:CGRectMake(0, 0, 100, 100)];
	[button setImage:[UIImage imageNamed:@"x.png"] forState:UIControlStateNormal];
	[button setTintColor:[UIColor redColor]];
	[button addTarget:self action:@selector(dismissMemoView) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:button];

}

- (void)dismissMemoView {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
