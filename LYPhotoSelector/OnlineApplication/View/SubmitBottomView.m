//
//  SubmitBottomView.m
//  LYPhotoSelector
//
//  Created by Ivan Wu on 2017/11/27.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "SubmitBottomView.h"
#import "OnlineConst.h"

@interface SubmitBottomView()
@property (nonatomic, strong)UIButton *confirmButton;
@end
@implementation SubmitBottomView
- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        UIButton *bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.confirmButton = bottomBtn;
        bottomBtn.frame = CGRectMake(AdaptedWidth(16), AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), CGRectGetHeight(self.frame) - 2 * AdaptedHeight(16));
        bottomBtn.backgroundColor = RGB(199, 0, 11);
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomBtn.titleLabel.font = kFontSize(14);
        [bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
        bottomBtn.layer.cornerRadius = AdaptedHeight(20);
        [self addSubview:bottomBtn];
    }
    return self;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [self.confirmButton addTarget:target action:action forControlEvents:controlEvents];
}
@end
