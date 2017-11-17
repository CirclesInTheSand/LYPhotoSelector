//
//  CustomToolView.m
//  TestMutiRequest
//
//  Created by company on 12/6/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "CustomToolView.h"

#define kBottomLineColor [UIColor colorWithRed:41/255.0 green:191/255.0 blue:221/255.0 alpha:1]
#define kSelectedTitleColor [UIColor colorWithRed:48/255.0 green:52/255.0 blue:53/255.0 alpha:1]
#define kNormalTitleColor [UIColor colorWithRed:147/255.0 green:147/255.0 blue:147/255.0 alpha:1]



@interface CustomToolView ()
/** 记录上一次被选中的按钮 */
@property (nonatomic ,strong) UIButton *tempBtn;

/** 底部的线 */
@property (nonatomic ,strong) UIView *lineView;

/** 点击按钮回调 */
@property (nonatomic ,strong) ToolViewBlcok block;
@end

@implementation CustomToolView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles font:(CGFloat)font{
    
    self = [super init];
    if (self) {
        
        self.animation = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.titiles = titles;
        [self setUpChildViewsWithFontValue:(CGFloat)font];
        
    }
    return self;
}

- (void)setUpChildViewsWithFontValue:(CGFloat)fontValue
{
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = kBottomLineColor;
    for (NSInteger i = 0; i< self.titiles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        [btn setTitle:self.titiles[i] forState:UIControlStateNormal];
        [btn setTitleColor:kNormalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:kSelectedTitleColor forState:UIControlStateSelected];
        if(fontValue == 0)
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:14];
        }else
        {
            btn.titleLabel.font = [UIFont systemFontOfSize:fontValue];
        }
        
        btn.tag = i + 100;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) [self btnClick:btn];
        [self addSubview:btn];
    }
    
    if(self.animation)
    {
        self.lineView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 2, 0, 0);
    }
    [self addSubview:self.lineView];
}

#pragma mark -- didClickWithHandle /*为按钮添加点击方法*/
- (void)didClickBtnWithHandle:(ToolViewBlcok)handle{
    
    self.block = [handle copy];
}


#pragma mark -- 按钮点击方法
- (void)btnClick:(UIButton *)sender{
    
    self.tempBtn.selected = NO;
    sender.selected = YES;
    if (self.block) {
        self.block(sender.tag - 100);
    }
    self.tempBtn = sender;
    [self setNeedsLayout];
}

#pragma mark -- layoutSubviews
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    NSInteger i = 0;
    
    for (UIView *view  in self.subviews) {
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            CGFloat btnW = [UIScreen mainScreen].bounds.size.width / self.titiles.count;
            view.frame = CGRectMake(i * btnW, 0, btnW, CGRectGetHeight(self.frame));
        }
        
        if (view == self.lineView) {
            
            if (self.lineWidth == 0) {
                self.lineWidth = 30;
            }
            if (self.lineWidth == -1) {
                self.lineWidth = 0;
            }
            
            if(self.animation)
            {
                if(!view.frame.size.width){
                    view.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 2, self.lineWidth, 2);
                }
                
                [UIView animateWithDuration:0.3 animations:^{
                    CGPoint center = CGPointMake(0, 0);
                    center.y = view.center.y;
                    center.x = self.tempBtn.center.x;
                    view.center = center;
                    
                }];
            }else
            {
                view.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 2, self.lineWidth, 2);
                
                CGPoint tempCenter = CGPointMake(0, 0);
                tempCenter.y = view.center.y;
                tempCenter.x = self.tempBtn.center.x;
                view.center = tempCenter;
            }
            
        }
        
        i ++;
    }
}
@end
