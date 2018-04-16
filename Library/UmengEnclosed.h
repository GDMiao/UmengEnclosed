//
//  UmengEnclosed.h
//  MyUMeng
//
//  Created by Michael-Miao on 2018/4/14.
//  Copyright © 2018年 Michael. All rights reserved.
//  其他分享方法配置 参考: https://developer.umeng.com/docs/66632/detail/66825

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

typedef NS_ENUM(NSUInteger, SocialType) {
	SType_sina_wx_qq,
	SType_all
};
typedef NS_ENUM(NSUInteger, ShareType) {
	ShareText,
	SharePictures,
	SharePicturesAndText_sina,
	ShareWebPages,
	ShareMusic,
	ShareVideo,
	ShareWeChatExpression,
	ShareWeChatPrograms
};
@interface UmengEnclosed : NSObject
+ (instancetype)sharedUmengEnclosed;

#pragma mark -- 定制Text类型分享面板预定义平台
/**
 文本分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 data = @"text"
 */
- (void)customTextShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype textData:(id)data;

#pragma mark -- 定制Image类型分享面板预定义平台
/**
 图片分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"thumb":"thumbImgurl","original":@"originalImgurl"}
 */
- (void)customImageShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype imgUrlData:(id)data;

#pragma mark -- 定制Web类型分享面板预定义平台
/**
 网页分享
 
 @param socialType 分享平台选择
 @param sharetype  分享类型选择
 @param data       分享类型固定参数 {"title":"","descr":"","weburl":@""}
 */
- (void)customWebShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data;


@end
