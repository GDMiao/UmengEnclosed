//
//  UmengEnclosed.m
//  MyUMeng
//
//  Created by Michael-Miao on 2018/4/14.
//  Copyright © 2018年 Michael. All rights reserved.
//

#import "UmengEnclosed.h"

static UmengEnclosed *_instance = nil;
@interface UmengEnclosed ()
@property (strong, nonatomic) UIViewController *vc;
@end

@implementation UmengEnclosed
// 完整单例
+ (instancetype)sharedUmengEnclosed
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [[self alloc] init];
	});
	return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_instance = [super allocWithZone:zone];
	});
	return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
	return _instance;
}

#pragma mark -- -------------------------====
#pragma mark -- 定制Text类型分享面板预定义平台
/**
 文本分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 data = @"text"
 */
- (void)customTextShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype textData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 定制Image类型分享面板预定义平台
/**
 图片分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"thumb":"thumbImgurl","original":@"originalImgurl"}
 */
- (void)customImageShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype imgUrlData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 定制Web类型分享面板预定义平台
/**
 网页分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"text","descr":"text","weburl":@"url"}
 */
- (void)customWebShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 分享图文（支持新浪微博）
/**
 分享图文（支持新浪微博）
 
 @param vc super VC
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"text":"xxx","thumbImage":"icon","shareImage":@"url"} //如果有缩略图，则设置缩略图
 */
- (void)customImage_textXinLangShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 分享音乐
/**
 分享音乐
 
 @param vc super VC
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","musicUrl":"url"}
 */
- (void)customMusicShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 分享视频
/**
 分享视频
 
 @param vc super VC
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","videoUrl":"url"}
 */
- (void)customVedioShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 分享微信小程序
/**
 分享微信小程序
 
 @param vc super VC
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"xxx","descr":"xxx","webpageUrl":"兼容微信低版本网页地址","userName":"小程序username","path":"小程序页面路径，如 pages/page10007/page10007","logo":"logo.png"}
 */
- (void)customMiniProgramShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}

#pragma mark -- 分享微信表情
/**
 分享微信表情
 
 @param vc super VC
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"xxx","descr":"xxx","thumImage":"icon","imgFile":"xxxFile","type":"gif/png/jpg"}
 */
- (void)customEmoticonShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data
{
	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
}
#pragma mark -- 定制自己的分享面板预定义平台
/**
 配置分享面板 和 分享类型

 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型参数
 */
- (void)shareMenuViewWithVC:(id)vc SocialType:(SocialType)socialType ShareType:(ShareType)sharetype date:(id)data
{
	_vc = vc;
	if (socialType == SType_sina_wx_qq) {
		[UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone)]];
	
	} else {
		//[UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
	}
	__weak typeof(self) weakself = self;
	
	[UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
		// 根据获取的platformType确定所选平台进行下一步操作
		__strong typeof(self) strongself = weakself;

		switch (sharetype) {
			case ShareText:
				[strongself shareTextToPlatformType:platformType date:data];
				break;
			case SharePictures:
				[strongself shareImageToPlatformType:platformType date:data];
				break;
			case SharePicturesAndText_sina:
				[strongself shareImageAndTextToPlatformType:platformType date:data];
				break;
			case ShareWebPages:
				[strongself shareWebPageToPlatformType:platformType date:data];
				break;
			case ShareMusic:
				[strongself shareMusicToPlatformType:platformType date:data];
				break;
			case ShareVideo:
				[strongself shareVedioToPlatformType:platformType date:data];
				break;
			case ShareWeChatExpression:
				[strongself shareEmoticonToPlatformType:platformType date:data];
				break;
			case ShareWeChatPrograms:
				[strongself shareMiniProgramToPlatformType:platformType date:data];
				break;
			default:
				break;
		}
	}];
}

#pragma mark  -- 分享文本
// 分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	NSString *text = data;
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//设置文本
	messageObject.text = text;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享图片
// 分享图片 {"thumb":"thumbImgurl","original":@"originalImgurl"}
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	NSDictionary *dict = data;
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建图片内容对象
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	//如果有缩略图，则设置缩略图
	shareObject.thumbImage = dict[@"thumbImgurl"];
	[shareObject setShareImage:dict[@"originalImgurl"]];
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享网页
// 分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	NSDictionary *dict = data;
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建网页内容对象
	UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:dict[@"title"] descr:dict[@"descr"] thumImage:[UIImage imageNamed:@"icon"]];
	//设置网页地址
	shareObject.webpageUrl =dict[@"weburl"];
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享图文（支持新浪微博）
- (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//设置文本
	messageObject.text = data[@"text"]?data[@"text"]:@"社会化组件UShare将各大社交平台接入您的应用，快速武装App。";
	//创建图片内容对象
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	//如果有缩略图，则设置缩略图
	shareObject.thumbImage = [UIImage imageNamed:data[@"icon"]];
	[shareObject setShareImage:data[@"shareImage"]?data[@"shareImage"]:@"https://www.umeng.com/img/index/demo/1104.4b2f7dfe614bea70eea4c6071c72d7f5.jpg"];
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享音乐
// {"title":"xxx","descr":"xxx","thumImage":"icon","musicUrl":"url"}
- (void)shareMusicToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建音乐内容对象
	UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:data[@"icon"]]];
	//设置音乐网页播放地址
	shareObject.musicUrl = data[@"musicUrl"];
	//            shareObject.musicDataUrl = @"这里设置音乐数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享视频
// {"title":"xxx","descr":"xxx","thumImage":"icon","videoUrl":"url"}
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	//创建视频内容对象
	UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:data[@"icon"]]];
	//设置视频网页播放地址
	shareObject.videoUrl = data[@"videoUrl"];
	//            shareObject.videoStreamUrl = @"这里设置视频数据流地址（如果有的话，而且也要看所分享的平台支不支持）";
	//分享消息对象设置分享内容对象
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.vc completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			NSLog(@"response data is %@",data);
		}
	}];
}

#pragma mark -- 分享微信表情
// {"title":"xxx","descr":"xxx","thumImage":"icon","imgFile":"xxxFile","type":"gif/png/jpg"}
- (void)shareEmoticonToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	UMShareEmotionObject *shareObject = [UMShareEmotionObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:nil];
	NSString *filePath = [[NSBundle mainBundle] pathForResource:data[@"imgFile"]
														 ofType:data[@"type"]];
	NSData *emoticonData = [NSData dataWithContentsOfFile:filePath];
	shareObject.emotionData = emoticonData;
	messageObject.shareObject = shareObject;
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			NSLog(@"************Share fail with error %@*********",error);
		}else{
			if ([data isKindOfClass:[UMSocialShareResponse class]]) {
				UMSocialShareResponse *resp = data;
				//分享结果消息
				NSLog(@"response message is %@",resp.message);
			}else{
				NSLog(@"response data is %@",data);
			}
		}
	}];
}

#pragma mark -- 分享微信小程序
// {"title":"xxx","descr":"xxx","webpageUrl":"兼容微信低版本网页地址","userName":"小程序username","path":"小程序页面路径，如 pages/page10007/page10007","logo":"logo.png"}
- (void)shareMiniProgramToPlatformType:(UMSocialPlatformType)platformType date:(id)data
{
	//创建分享消息对象
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	UMShareMiniProgramObject *shareObject = [UMShareMiniProgramObject shareObjectWithTitle:data[@"title"] descr:data[@"descr"] thumImage:[UIImage imageNamed:@"icon"]];
	shareObject.webpageUrl = data[@"webpageUrl"];
	shareObject.userName = data[@"userName"];
	shareObject.path = data[@"path"];
	messageObject.shareObject = shareObject;
	shareObject.hdImageData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:data[@"logo"] ofType:@"png"]];
	shareObject.miniProgramType = UShareWXMiniProgramTypeRelease; // 可选体验版和开发板
	//调用分享接口
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			UMSocialLogInfo(@"************Share fail with error %@*********",error);
		}else{
			if ([data isKindOfClass:[UMSocialShareResponse class]]) {
				UMSocialShareResponse *resp = data;
				//分享结果消息
				UMSocialLogInfo(@"response message is %@",resp.message);
				//第三方原始返回的数据
				UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
			}else{
				UMSocialLogInfo(@"response data is %@",data);
			}
		}
		// alert
	}];
}

@end
