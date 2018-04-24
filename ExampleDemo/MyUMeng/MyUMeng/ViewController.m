//
//  ViewController.m
//  MyUMeng
//
//  Created by Michael-Miao on 2018/4/14.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "ViewController.h"
#import "UmengEnclosed.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)umengSharedAciton:(id)sender {
	UmengEnclosed *umeng = [UmengEnclosed sharedUmengEnclosed];
	[umeng customTextShareWithVC:self SocialType:SType_sina_wx_qq shareType:ShareText textData:@"OK"];
}

@end
