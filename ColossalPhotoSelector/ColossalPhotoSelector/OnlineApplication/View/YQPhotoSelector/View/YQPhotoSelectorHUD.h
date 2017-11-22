//
//  YQPhotoSelectorHUD.h
//  PhotoSelect
//
//  Created by MyMacbook on 16/5/3.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQPhotoSelectorHUD : UIView

+(YQPhotoSelectorHUD *)sharedHud;

+(void)showHUDWithTitle:(NSString *)title;

+(void)hideHUD;

@end
