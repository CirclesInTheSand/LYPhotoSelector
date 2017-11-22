//
//  YQPhotoAnimationMnager.h
//  PhotoSelect
//
//  Created by MyMacbook on 16/5/4.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YQPhotoAnimationMnager : NSObject

+(YQPhotoAnimationMnager *)shareManager;

-(void)showCATransform3DMakeScaleAnimation:(UIView *)view;

@end
