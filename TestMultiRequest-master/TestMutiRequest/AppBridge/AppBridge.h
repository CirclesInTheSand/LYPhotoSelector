//
//  TestJSObject.h
//  TestJSOC
//
//  Created by 西游 on 7/25/15.
//  Copyright (c) 2015 com.xiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

//首先创建一个实现了JSExport协议的协议
@protocol TestJSObjectProtocol <JSExport>
@optional
//此处我们测试几种参数的情况
- (void)TestNoParameter;
- (void)TestOneParameter:(NSString *)message;
- (NSString *)TestTowParameter:(NSString *)message1 SecondParameter:(NSString *)message2;
- (void)Plus2Number:(NSString *)parameter1 andParameter2:(NSString *)parameter2;
- (id)iGiveObjectToYou;
/*仅仅是测试*/
@required
/**
 *  说明:设置用户选择的城市,如果无论成功失败都回调给h5以相应
 */
- (void)setSelectedRegion:(NSString *)dic;
/**
 *  说明:获取用户选择的城市 长期保存
 */
- (void)getSelectedRegion:(NSString *)dic;
/**
 *  说明:跳回tabbarController中指定的控制器
 */
- (void)popToSelectedController:(NSString *)dic;

/*
 *  关闭当前webview,并且返回指定的webview,在子webview中才有效
 *  isRoot: 值为1或者0，默认为0。
 *	0: 关闭当前webview
 *  1: 关闭所有子webview，返回到主webview中
 */
- (void)close:(NSString *)dic;
/*
 * 说明：在webview中加载url。
 * url: 加载的网页地址
 * target: 值为：self/blank
 * self: 在当前webview中打开
 * blank: 在新的子webview打开
 */
- (void)openUrl:(NSString *)dic;
/*
 * 说明：获取当前手机的经纬度 需要调用appCallback来传递所获得参数
 */
- (void)getCurrentPosition:(NSString *)dic;

/*
 * 说明: 获取当前的城市以及区域(包括编号以及名字) 需要调用appCallback来传递所需参数
 */
- (void)getCurrentRegion:(NSString *)dic;

/*
 * 说明:隐藏消息框 暂未实现
 */
- (void)closeLoading;
/*
 * 说明:判断用户是否登录
 */
- (void)getUserState:(NSString *)dic;

/*
 * 说明:获取tabbar下文字对应的索引字典
 */
- (void)getTabbarDic:(NSString *)dic;
/*
 * 说明:打电话
 */
- (void)makeCall:(NSString *)dic;
/**
 * @params:显示影院地图
 **/
- (void)showCinemaMap:(NSString *)dic;

/**
 * @params:调用支付
 **/
- (void)launchAppPay:(NSString *)dic;

/**
 * @params:改变导航条颜色
 **/
- (void)changeRightButColor:(NSString *)dic;
/**
 *
 *
 *  @param dic 设置用户信息
 */
- (void)setUserInfo:(NSString *)dic;
/**
 *  选择电影和影院的切换
 *
 *  @param dic 需要传递的JSON字典
 */
- (void)changeBuyTicketType:(NSString *)dic;
/**
 *  隐藏或显示导航条
 *
 *  @param dic 需要传递的JSON字典
 */
- (void)topBarVisible:(NSString *)dic;

/**
 *  清除缓存
 */
- (void)clearCache;
/**
 *  是否要取消移动话费支付
 */
- (void)isCancelMobilePay:(NSString *)dic;
/**
 *  是否需要禁止后退按钮
 *
 *  @param dic
 */
- (void)backButtonEnabled:(NSString *)dic;
/**
 *  网络状态发生改变
 *
 *  @param dic
 */
- (void)networkStatusChanged:(NSString *)dic;
/**
 *  是否隐藏视频播放网页的自定义导航条
 *
 *  @param dic
 */
- (void)videoPlayTitleShow:(NSString *)dic;

/**
 *  改变购物车商品数量
 *
 *  @param dic
 */
- (void)changeCartGoods:(NSString *)dic;

/**
 *  Apple Pay支付回调结果
 */
-(void)tellAppAppleSuccess:(NSString *)dic;


/**
 微信分享有关接口

 @param dic 字典
 */
- (void)shareToWeixinFriendsWithData:(NSString *)dic;

/**
 *  获取当前的版本信息
 *
 *  @param dic 
 */
- (void)getCurrentVersion:(NSString *)dic;
/**
 *  更新购票页页面
 *
 *  @param dic
 */
- (void)updateBuyTicketInterfaceIfNecessary:(NSString *)dic;
/**
 *  更新状态栏
 *
 *  @param dic
 */
- (void)flexBoxRefresh:(NSString *)dic;

/**
 用safari打开指定的url

 @param dic 字典
 */
- (void)openUrlWithSafari:(NSString *)dic;

/**
 保存图片到相册

 @param dic <#dic description#>
 */
- (void)saveImageToPhotos:(NSString *)dic;

/**
 分享图片到微信

 @param dic <#dic description#>
 */
- (void)shareBigImageToWeiXin:(NSString *)dic;


/**
 拍照或选择图片

 @param dic <#dic description#>
 */
- (void)replaceHead:(NSString *)dic;

/**
 设置消息数量

 @param dic <#dic description#>
 */
- (void)changeMsgCount:(NSString *)dic;

/**
 选择多张图片作为base64传递给h5

 @param dic <#dic description#>
 */
- (void)multiplePicUploads:(NSString *)dic;

/**
 友盟统计页面点击事件的处理

 @param dic
 */
- (void)onCountEvent:(NSString *)dic;


/**
 改变签到按钮的状态

 @param dic <#dic description#>
 */
- (void)changeButtonStatus:(NSString *)dic;

/**
 获取缓存大小
 */
- (void)getCacheSize:(NSString *)dic;
@end

//让我们创建的类实现上边的协议
@interface AppBridge: NSObject<TestJSObjectProtocol>
@property (nonatomic,weak)id<TestJSObjectProtocol> delegate;
//@property (nonatomic,weak)id<TestJSObject> delegate;
@end
