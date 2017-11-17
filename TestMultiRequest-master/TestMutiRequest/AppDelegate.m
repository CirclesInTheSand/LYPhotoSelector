//
//  AppDelegate.m
//  TestMutiRequest
//
//  Created by Calvix on 2017/4/29.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "AppDelegate.h"
#import "OnlineApplicationViewController.h"
#import "UIScrollView+MPAdjustment.h"
#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "DYLaunchScreen.h"
@interface AppDelegate ()
@property (nonatomic, strong)UIView *lauchView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    ViewController *viewController = [[ViewController alloc] init];

    UINavigationController *naviController = [[UINavigationController alloc] initWithRootViewController:viewController];
    naviController.view.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = naviController;

    [self.window makeKeyAndVisible];
    
    
    [DYLaunchScreen showLaunchScreenWithUrlString:@"http://172.16.10.130/eshop/adminapi/web/upload/base/2017/11/01/59f944911f17a/o.jpg" defaultImageName:@"Default-667h"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:kDismissLaunchScreenNotification object:nil];
    });

//    /**< 添加启动图 */
//    {
//        self.lauchView = [[UIView alloc] init];
//        self.lauchView.frame = CGRectMake(0, 0, self.window.screen.bounds.size.width, self.window.screen.bounds.size.height);
//        [self.window addSubview:self.lauchView];
//
//        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.lauchView.bounds.size.width, self.lauchView.bounds.size.height)];
//        NSString *str = @"http://172.16.10.130/eshop/adminapi/web/upload/base/2017/11/01/59f944911f17a/o.jpg";
//        [imageV sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"Default-667h"]];
//        [self.lauchView addSubview:imageV];
//
//        [self.window bringSubviewToFront:self.lauchView];
//
//        [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeLun) userInfo:nil repeats:NO];
//    }


    return YES;
}

- (void)removeLun{
    [self.lauchView removeFromSuperview];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
