//
//  AppDelegate+UMeng.m
//  MyUMeng
//
//  Created by Michael-Miao on 2018/4/14.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

@implementation AppDelegate (UMeng)
	
- (BOOL)umengapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// UMConfigure 通用设置，请参考SDKs集成做统一初始化。
	[UMConfigure initWithAppkey:@"UMengAppKey" channel:@"App Store"];
	[UMConfigure setLogEnabled:YES];
	// U-Share 平台设置
	[self configUSharePlatforms];
	[self confitUShareSettings];
	return YES;
}
	
// 设置系统回调
// 支持所有iOS系统
- (BOOL)umengapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}
	
// 仅支持iOS9以上系统，iOS8及以下系统不会回调
- (BOOL)umengapplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
	BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

// 2.支持目前所有iOS系统
- (BOOL)umengapplication:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	if (!result) {
		// 其他如支付等SDK的回调
	}
	return result;
}

	
- (void)confitUShareSettings
{
	/*
	 * 打开图片水印
	 */
	//[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
	/*
	 * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
	 <key>NSAppTransportSecurity</key>
	 <dict>
	 <key>NSAllowsArbitraryLoads</key>
	 <true/>
	 </dict>
	 */
	//[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
	
- (void)configUSharePlatforms
{
	/* 设置微信的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx2aa39f61677ccf3e" appSecret:@"cf3bf7181a628246732c114e38195c85" redirectURL:@"http://mobile.umeng.com/social"];
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wx2aa39f61677ccf3e" appSecret:@"cf3bf7181a628246732c114e38195c85" redirectURL:@"http://mobile.umeng.com/social"];
	/*
	 * 移除相应平台的分享，如微信收藏
	 */
	//[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
	/* 设置分享到QQ互联的appID
	 * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
	 */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1106607349"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Qzone appKey:@"1106607349"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
	/* 设置新浪的appKey和appSecret */
	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
	
//	/* 钉钉的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//	/* 支付宝的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//	/* 设置易信的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//	/* 设置点点虫（原来往）的appKey和appSecret */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//	/* 设置领英的appKey和appSecret */
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//	/* 设置Twitter的appKey和appSecret */
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//	/* 设置Facebook的appKey和UrlString */
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
//	/* 设置Pinterest的appKey */
//	[[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//	/* dropbox的appKey */
//	[[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//	/* vk的appkey */
//	[[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
}
	
	
@end
