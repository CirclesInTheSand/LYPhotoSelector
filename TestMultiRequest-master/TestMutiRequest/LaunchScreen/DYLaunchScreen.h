//
//  DYLaunchScreen.h
//  TestMutiRequest
//
//  Created by Ivan Wu on 2017/11/16.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *kDismissLaunchScreenNotification = @"DismissLaunchScreenNotification";

@interface DYLaunchScreen : UIView

/**
 获取启动图单例

 @return 启动图
 */
+ (instancetype)sharedLaunchScreen;

/**
 显示启动图

 @param urlString 来源的url
 @param imageName 默认的图片名称
 */
+ (void)showLaunchScreenWithUrlString:(NSString *)urlString defaultImageName:(NSString *)imageName;
@end
