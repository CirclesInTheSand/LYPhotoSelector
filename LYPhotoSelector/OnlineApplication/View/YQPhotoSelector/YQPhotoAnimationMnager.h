//
//  YQPhotoAnimationMnager.h
//  PhotoSelect
//
//  Created by Mopon on 16/5/4.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YQPhotoAnimationMnager : NSObject

+(YQPhotoAnimationMnager *)shareManager;

-(void)showCATransform3DMakeScaleAnimation:(UIView *)view;

@end
