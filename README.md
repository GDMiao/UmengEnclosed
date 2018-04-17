# 对友盟分享（Umeng-Share）的功能封装
---

## 引言
本文档针对友盟分享（6.9.0）进行了功能封装，完成的对于 **文字**、**图片**、**网页** 分享功能封装，如有其它封装要求请根据本文档的封装思路和[友盟分享 api](https://developer.umeng.com/docs/66632/detail/66825)再进行功能封装。
😝话不多言，看看代码吧。

### 封装主要完成几部
* Cocoapods 集成友盟分享 SDK
* 配置SSO白名单
* 配置URL Scheme
* AppDelegate+UMeng
* UmengEnclosed

![App + Umeng.png](quiver-image-url/22B4FE64D036B608ABFE39CEA21908D4.png =260x87)


### Cocoapods 集成、白名单、URL Scheme 
这部分太啰嗦，也没有必要，需要的直接去官方文档查阅 [**U-Share集成文档**](https://developer.umeng.com/docs/66632/detail/66825)

### AppDelegate+UMeng
这里是对 `AppDelegate` 做了一个 Category 分类处理，在 AppDelegate 中好区别去其他第三方平台 SDK 注册和配置来调用`U-Share SDK` 的调用。
这部分就不多说了，大家都懂，直接上代码。

1. AppDelegate+UMeng.h
    ```
    #import "AppDelegate.h"
    
    @interface AppDelegate (UMeng)
    // 友盟系统配置和注册
    - (BOOL)umengapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
    // 设置系统回调
    // 支持所有iOS系统
    - (BOOL)umengapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
    	
    // 仅支持iOS9以上系统，iOS8及以下系统不会回调
    - (BOOL)umengapplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options;
    	
    // 2.支持目前所有iOS系统
    - (BOOL)umengapplication:(UIApplication *)application handleOpenURL:(NSURL *)url;
    @end
    ```
2. AppDelegate+UMeng.m
此部分代码过多只展示部分逻辑，有需要请到 [GDMiao/UmengEnclosed](https://github.com/GDMiao/UmengEnclosed) 下载查看。

    a. // 友盟系统配置和注册
    ```
    // 友盟系统配置和注册
    - (BOOL)umengapplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
    {
  	    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
        [UMConfigure initWithAppkey:@"你的UMAPPKey" channel:@"App Store"];
        [UMConfigure setLogEnabled:YES];
  	    // U-Share 平台设置
        [self configUSharePlatforms]; // 配置参考官方文档
        [self confitUShareSettings];  // 配置参考官方文档
   	    return YES; 
    }
    ```
    b. 系统回调 
    ```
    // 1.支持所有iOS系统
    - (BOOL)umengapplication:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
    {
        //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
      	BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
        if (!result) {
	    	// 其他如支付等SDK的回调
      	}
      	return result;
    }
    
    // 2.仅支持iOS9以上系统，iOS8及以下系统不会回调
    - (BOOL)umengapplication:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
    {
      	//6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
        BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
        if (!result) {
		    // 其他如支付等SDK的回调
      	}
      	return result;
    }

    // 3.支持目前所有iOS系统
    - (BOOL)umengapplication:(UIApplication *)application handleOpenURL:(NSURL *)url
    {
         BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
	     if (!result) {
	        // 其他如支付等SDK的回调
	     }
	     return result;
    }
    ```
### UmengEnclosed
这部分是对友盟分享的关键封装，定制了 文本字、图片、网页 三种分享，分钟分享有固定的参数形式。

 1. UmengEnclosed.h
    ```
    #pragma mark -- 定制Text类型分享面板预定义平台
    /**
    文本分享
     @param vc         分享方法调用的 Controller
     @param socialType 分享平台选择
     @param sharetype  分享类型选择
     @param data       分享类型固定参数 data = @"text"
     */
    - (void)customTextShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype textData:(id)data;

    #pragma mark -- 定制Image类型分享面板预定义平台
    /**
     图片分享
     @param vc         分享方法调用的 Controller
     @param socialType 分享平台选择
     @param sharetype  分享类型选择
     @param data       分享类型固定参数 {"thumb":"thumbImgurl","original":@"originalImgurl"}
     */
    - (void)customImageShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype imgUrlData:(id)data;
    
    #pragma mark -- 定制Web类型分享面板预定义平台
    /**
     网页分享
     @param vc         分享方法调用的 Controller
     @param socialType 分享平台选择
     @param sharetype  分享类型选择
     @param data       分享类型固定参数 {"title":"","descr":"","weburl":@""}
     */
    - (void)customWebShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype webData:(id)data;
    ```
 2. UmengEnclosed.m
 
     a. 此部分根据 `SocialType` 定制分享面板，根据`ShareType`定制分享方法，`data` 根骨分享方法配置参数。
    ```
    #pragma mark -- 定制自己的分享面板预定义平台
    /**
     配置分享面板 和 分享类型
     @param vc         分享方法调用的 Controller
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
    				[strongself shareTextToPlatformType:platformType date:data]; // 根据友盟文档定制方法
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
    ```
    b. 分享文本
    ```
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
    ```
    c.调用文本分享定制方法
    ```
    /**
     文本分享
     @param vc         分享方法调用的 Controller
     @param socialType 分享平台选择
     @param sharetype  分享类型选择
     @param data       分享类型固定参数 data = @"text"
     */
    - (void)customTextShareWithVC:(id)vc SocialType:(SocialType)socialType shareType:(ShareType)sharetype textData:(id)data
    {
    	[self shareMenuViewWithVC:vc SocialType:socialType ShareType:sharetype date:data];
    }
    ```
    d.不一一举例详情请参考 [GDMiao/UmengEnclosed](https://github.com/GDMiao/UmengEnclosed) 下载查看。


### 具体调用


  ```
  #import "UmengEnclosed.h"
  
  - (IBAction)UmengSharedAciton:(id)sender {
  	UmengEnclosed *umeng = [UmengEnclosed sharedUmengEnclosed];
  	[umeng customTextShareWithVC:self SocialType:SType_sina_wx_qq shareType:ShareText textData:@"OK"];
  }
  
  ```
  
### 结语
本次封装只定制我我方 APP 的对应分享的部分功能，如有需要请更加文档自行定制。
如果您能读到点这里我非常感谢。
