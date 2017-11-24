//
//  OnlineSectionHeaderView.m
//  LYPhotoSelector
//
//  Created by Pine on 17/10/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "OnlineSectionHeaderView.h"
#import "OnlineConst.h"

@implementation OnlineSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier model:(MaterialModel *)materialModel{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        self.frame = CGRectMake(0, 0, Screen_Width, AdaptedHeight(39));
        self.contentView.backgroundColor = UIColor.whiteColor;
        
        UIView *straightLine = [[UIView alloc] initWithFrame:CGRectMake(AdaptedWidth(16), AdaptedHeight(12), AdaptedWidth(2), AdaptedHeight(16))];
        straightLine.backgroundColor = RGB(197, 8, 25);
        [self.contentView addSubview:straightLine];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(straightLine.frame) + AdaptedWidth(4), AdaptedHeight(16), 100, AdaptedHeight(8))];
        textLabel.font = kFontSize(16);
        textLabel.text = materialModel.cellTitle;
        textLabel.textColor = RGB(51, 51, 51);
        textLabel.tag = 999;
        [self.contentView addSubview:textLabel];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(AdaptedWidth(9), CGRectGetHeight(self.frame) - SINGLE_LINE_WIDTH, Screen_Width - AdaptedWidth(18), SINGLE_LINE_WIDTH)];
        bottomLine.backgroundColor = RGB(191, 191, 191);
        [self.contentView addSubview:bottomLine];
    }
    return self;
}

- (instancetype)initWithModel:(MaterialModel *)materialModel{
    self = [super init];
    if(self){
        self.frame = CGRectMake(0, 0, Screen_Width, AdaptedHeight(40));
        self.backgroundColor = UIColor.whiteColor;
        
        UIView *straightLine = [[UIView alloc] initWithFrame:CGRectMake(AdaptedWidth(16), AdaptedHeight(12), AdaptedWidth(2), AdaptedHeight(16))];
        straightLine.backgroundColor = RGB(197, 8, 25);
        [self addSubview:straightLine];
        
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(straightLine.frame) + AdaptedWidth(4), AdaptedHeight(16), 100, AdaptedHeight(8))];
        textLabel.font = kFontSize(16);
        textLabel.text = materialModel.cellTitle;
        textLabel.textColor = RGB(51, 51, 51);
        textLabel.tag = 999;
        [self addSubview:textLabel];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(AdaptedWidth(9), CGRectGetHeight(self.frame) - SINGLE_LINE_WIDTH, Screen_Width - AdaptedWidth(18), SINGLE_LINE_WIDTH)];
        bottomLine.backgroundColor = RGB(191, 191, 191);
        [self addSubview:bottomLine];
    }
    return self;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    ((UILabel *)[self viewWithTag:999]).text = titleString;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
