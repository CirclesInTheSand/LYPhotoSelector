//
//  YQPhotoSelectorToolView.m
//  PhotoSelect
//
//  Created by PINE on 16/5/3.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import "YQPhotoSelectorToolView.h"
#import "YQPhotoAnimationMnager.h"

@interface YQPhotoSelectorToolView ()

@property (nonatomic ,strong)UIView *lineView;

@property (nonatomic ,strong)UIButton *preViewBtn;

@property (nonatomic ,strong)UIButton *doneBtn;

@property (nonatomic ,strong)UILabel *countLabel;

@end

@implementation YQPhotoSelectorToolView

-(instancetype)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self setUpviews];
    }
    return self;
}

-(instancetype)init{

    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setUpviews{

    self.backgroundColor = [UIColor whiteColor];
    
//    顶部线
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [self addSubview:self.lineView];
    self.lineView.translatesAutoresizingMaskIntoConstraints=NO;
    
    
    
//    预览按钮，暂不实现
    self.preViewBtn = [[UIButton alloc]init];
    self.preViewBtn.hidden = true;
    [self.preViewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self.preViewBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:self.preViewBtn];
    self.preViewBtn.translatesAutoresizingMaskIntoConstraints=NO;

    
//    完成按钮
    self.doneBtn = [[UIButton alloc]init];
    [self.doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.doneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.doneBtn addTarget:self action:@selector(donBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.doneBtn];
    self.doneBtn.translatesAutoresizingMaskIntoConstraints=NO;
    
//    圆点
    self.countLabel = [[UILabel alloc]init];
    self.countLabel.backgroundColor = [UIColor redColor];
    self.countLabel.textColor = [UIColor whiteColor];
    self.countLabel.textAlignment = NSTextAlignmentCenter;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.layer.cornerRadius = 26/2;
    self.countLabel.text = @"0";
    [self addSubview:self.countLabel];
    self.countLabel.translatesAutoresizingMaskIntoConstraints=NO;
    
    [self addViewConstraints];

}

//添加约束
-(void)addViewConstraints{

    NSArray *lineConstraintsH=[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_lineView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lineView)];
    NSArray *lineConstraintsV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_lineView(==1)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_lineView)];
    
    NSArray *viewConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[_preViewBtn(==50)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_preViewBtn)];
    NSArray *viewConstraintsV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_preViewBtn(30)]"  options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_preViewBtn)];
    
    NSArray *doneConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[_countLabel(==26)]-10-[_doneBtn(==50)]-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_countLabel,_doneBtn)];
    NSArray *doneConstraintsV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_doneBtn(30)]"  options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_doneBtn)];
    
    NSArray *countConstraintsV=[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_countLabel(26)]"  options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(_countLabel)];
    
    [self addConstraints:lineConstraintsH];
    [self addConstraints:lineConstraintsV];
    
    [self addConstraints:viewConstraintsH];
    [self addConstraints:viewConstraintsV];
    
    [self addConstraints:doneConstraintsH];
    [self addConstraints:doneConstraintsV];
    
    [self addConstraints:countConstraintsV];
    
}

-(void)setSelectCount:(NSInteger)count{
    [[YQPhotoAnimationMnager shareManager] showCATransform3DMakeScaleAnimation:self.countLabel];
    self.countLabel.text = [NSString stringWithFormat:@"%zd",count];
}

//完成按钮
-(void)donBtnClick{

    if ([self.delegate respondsToSelector:@selector(didClickedDoneBtn:)]) {
        [self.delegate didClickedDoneBtn:self.doneBtn];
    }

}

@end
