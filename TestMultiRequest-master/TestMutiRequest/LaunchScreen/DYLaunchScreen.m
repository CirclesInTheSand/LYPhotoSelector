//
//  DYLaunchScreen.m
//  TestMutiRequest
//
//  Created by Ivan Wu on 2017/11/16.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "DYLaunchScreen.h"
#import "UIImageView+WebCache.h"

@implementation DYLaunchScreen
static DYLaunchScreen *instance = nil;
+ (instancetype)sharedLaunchScreen
{
    @synchronized(self){
        if (instance  == nil){
            instance = [[DYLaunchScreen alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(dismissLaunchScreen) name:kDismissLaunchScreenNotification object:nil];
        }
    }
    return instance;
}


+ (void)showLaunchScreenWithUrlString:(NSString *)urlString defaultImageName:(NSString *)imageName{
    if(![self validatePath:urlString])return;
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    DYLaunchScreen *sharedLaunchScreen = [DYLaunchScreen sharedLaunchScreen];
    [keyWindow addSubview:sharedLaunchScreen];
    
    UIImageView *screenImageView = [[UIImageView alloc] initWithFrame:sharedLaunchScreen.bounds];
    [sharedLaunchScreen addSubview:screenImageView];
    [screenImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:imageName]];
}

#pragma mark -- Verification
+ (BOOL)validatePath:(NSString *)path
{
    NSURL *url = [NSURL URLWithString:path];
    return url != nil;
}
#pragma mark -- 关闭
- (void)dismissLaunchScreen{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
