//
//  YQPhotoAnimationMnager.m
//  PhotoSelect
//
//  Created by Mopon on 16/5/4.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQPhotoAnimationMnager.h"

@implementation YQPhotoAnimationMnager
+(YQPhotoAnimationMnager *)shareManager{

    static YQPhotoAnimationMnager *sharedAnimationMnager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAnimationMnager = [[self alloc] init];
    });
    return sharedAnimationMnager;
}

-(void)showCATransform3DMakeScaleAnimation:(UIView *)view{

    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.4;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    
    [view.layer addAnimation:animation forKey:nil];

}

@end
