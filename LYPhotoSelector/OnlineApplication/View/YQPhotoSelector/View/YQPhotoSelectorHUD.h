//
//  YQPhotoSelectorHUD.h
//  PhotoSelect
//
//  Created by PINE on 16/5/3.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQPhotoSelectorHUD : UIView

+(YQPhotoSelectorHUD *)sharedHud;

+(void)showHUDWithTitle:(NSString *)title;

+(void)hideHUD;

@end
