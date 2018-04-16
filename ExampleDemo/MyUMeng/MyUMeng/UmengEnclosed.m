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
				
				break;
			case ShareWebPages:
				[strongself shareWebPageToPlatformType:platformType date:data];
				break;
			case ShareMusic:
				
				break;
			case ShareVideo:
				
				break;
			case ShareWeChatExpression:
				
				break;
			case ShareWeChatPrograms:
				
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
@end
