//
//  YQPhotoSelectorHUD.h
//  PhotoSelect
//
//  Created by Mopon on 16/5/3.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQPhotoSelectorHUD : UIView

+(YQPhotoSelectorHUD *)sharedHud;

+(void)showHUDWithTitle:(NSString *)title;

+(void)hideHUD;

@end
