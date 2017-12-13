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
        
        UIView *straightLine = [[UIView alloc] init];
        straightLine.backgroundColor = RGB(197, 8, 25);
        [self.contentView addSubview:straightLine];
        /**< 灰线布局 */
        [straightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidth(16));
            make.top.mas_equalTo(AdaptedHeight(12));
            make.width.mas_equalTo(AdaptedWidth(2));
            make.height.mas_equalTo(AdaptedHeight(16));
        }];
        
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = kFontSize(16);
        textLabel.text = materialModel.cellTitle;
        textLabel.textColor = RGB(51, 51, 51);
        textLabel.tag = 999;
        [self.contentView addSubview:textLabel];
        
        /**< 标签布局 */
        [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(straightLine.mas_left).offset(AdaptedWidth(4));
            make.top.mas_equalTo(AdaptedHeight(16));
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(AdaptedHeight(8));
        }];
        
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(191, 191, 191);
        [self.contentView addSubview:bottomLine];
        
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(9);
            make.bottom.mas_equalTo(self).offset(-SINGLE_LINE_WIDTH);
            make.right.mas_equalTo(self).offset(-AdaptedWidth(8));
            make.height.mas_equalTo(SINGLE_LINE_WIDTH);
            
        }];
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
