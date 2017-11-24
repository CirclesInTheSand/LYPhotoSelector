//
//  YQPhotoAnimationMnager.h
//  PhotoSelect
//
//  Created by PINE on 16/5/4.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YQPhotoAnimationMnager : NSObject

+(YQPhotoAnimationMnager *)shareManager;

-(void)showCATransform3DMakeScaleAnimation:(UIView *)view;

@end
