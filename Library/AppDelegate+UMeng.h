//
//  AppDelegate+UMeng.h
//  MyUMeng
//
//  Created by Michael-Miao on 2018/4/14.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (UMeng)
	
- (BOOL)umengapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
// 设置系统回调
// 支持所有iOS系统
- (BOOL)umengapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
	
// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)umengapplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
	
// 2.支持目前所有iOS系统
- (BOOL)umengapplication:(UIApplication *)application handleOpenURL:(NSURL *)url;
@end
