//
//  YQPhotoSelectorHUD.m
//  PhotoSelect
//
//  Created by Mopon on 16/5/3.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQPhotoSelectorHUD.h"

@interface YQPhotoSelectorHUD ()

@property (strong ,nonatomic) UIView *hudView;

@property (nonatomic ,strong)UILabel *hudLabel;

@end

@implementation YQPhotoSelectorHUD

+(YQPhotoSelectorHUD *)sharedHud
{
    static YQPhotoSelectorHUD *_photoHud = nil;
    if (_photoHud == nil) {
        _photoHud = [[YQPhotoSelectorHUD alloc]init];
    }
    return _photoHud;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
-(void) removeHudUI;
{
    [UIView animateWithDuration:0.3 animations:^{
        
        _hudView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        _hudView = nil;
        _hudLabel = nil;
        [self removeFromSuperview];
    }];
}
-(void) makeInitUI
{
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

-(void) makeHudUIWithTitle:(NSString *)title
{
    _hudLabel = [[UILabel alloc] init];
    _hudLabel.textAlignment = NSTextAlignmentCenter;
    _hudLabel.font = [UIFont systemFontOfSize:15];
    _hudLabel.textColor = [UIColor whiteColor];
    _hudLabel.text = title;
    [_hudLabel sizeToFit];
    
    
    CGFloat hudViewWidth = _hudLabel.frame.size.width +20;
    
    CGFloat hudViewHeight = _hudLabel.frame.size.height +20;
    
    _hudView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, hudViewWidth, hudViewHeight)];
    _hudView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    _hudView.layer.cornerRadius = 8;
    _hudView.clipsToBounds = YES;
    _hudView.backgroundColor = [UIColor blackColor];
    _hudView.alpha = 0;
    
    _hudLabel.center = CGPointMake(hudViewWidth/2,hudViewHeight/2);
    
    [_hudView addSubview:_hudLabel];
    [self addSubview:_hudView];

    [UIView animateWithDuration:0.3 animations:^{
       
        _hudView.alpha = 0.8;
        
    }];
    
}
+(void)showHUDWithTitle:(NSString *)title{

    [[self sharedHud] makeInitUI];
    
    [[self sharedHud] makeHudUIWithTitle:title];
    
    [[self sharedHud] show];
    
    [self performSelector:@selector(hideHUD) withObject:nil afterDelay:1.f];
}

+(void)hideHUD{

    [[self sharedHud] removeHudUI];
}

@end
