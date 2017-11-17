//
//  UITableViewMaterialCell.m
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#define OriginBtnCellX AdaptedWidth(16)
#define OriginBtnCellY AdaptedHeight(16)
#define OriginBtnXGap AdaptedWidth(10)
#define OriginBtnYGap AdaptedHeight(10)
#define MaterialBtnWidth (Screen_Width - AdaptedWidth(63))/4.0
#define MaterialBtnHeight MaterialBtnWidth

#import "UITableViewMaterialCell.h"
#import "MaterialBtn.h"
#import "OnlineConst.h"
@interface UITableViewCell ()
@end

@implementation UITableViewMaterialCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -- 按钮点击事件

- (void)imageBtnClicked:(UIButton *)sender{
    if(sender.selected){
        [self.delegate didClickDeleteBtn];
    }else{
        [self.delegate didClickAddBtn];
    }
}

#pragma mark -- 模型赋值
- (void)fillCellWithModel:(MaterialModel *)model{
    //清除以前的视图
    for(id view in self.contentView.subviews){
        if([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[UIButton class]]){
            [view removeFromSuperview];
        }
    }
    
    UILabel *firstTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(OriginBtnCellX, AdaptedHeight(15), Screen_Width, AdaptedHeight(18))];
    firstTitleLabel.font = kFontSize(12);
    firstTitleLabel.textColor = [UIColor blackColor];
    firstTitleLabel.text = @"身份证复印件";
    [self.contentView addSubview:firstTitleLabel];
    
    CGFloat maxTitleLabelY = CGRectGetMaxY(firstTitleLabel.frame);
    CGFloat maxBtnY = 0;
    NSInteger arrayCount = model.firstTypeMaterial.count;
    for (NSInteger index = 0; index < arrayCount; index ++){
        MaterialBtn *btn = [MaterialBtn buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.frame = CGRectMake(OriginBtnCellX + index * (OriginBtnXGap + MaterialBtnWidth), maxTitleLabelY + (index / 4 + 1) * OriginBtnYGap, MaterialBtnWidth, MaterialBtnHeight);
        maxBtnY = CGRectGetMaxY(btn.frame);
        btn.selected = (arrayCount - 1 == index);
        [btn addTarget:self action:@selector(imageBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
    
    UILabel *secondTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(firstTitleLabel.frame), maxBtnY + OriginBtnCellY, CGRectGetWidth(firstTitleLabel.frame), CGRectGetHeight(firstTitleLabel.frame))];
    secondTitleLabel.font = firstTitleLabel.font;
    secondTitleLabel.textColor = [UIColor blackColor];
    secondTitleLabel.text = @"户口本";
    [self.contentView addSubview:secondTitleLabel];
    
    arrayCount = model.secondTypeMaterial.count;
    maxTitleLabelY = CGRectGetMaxY(secondTitleLabel.frame);
    for (NSInteger index = 0; index < model.secondTypeMaterial.count; index ++){
        MaterialBtn *btn = [MaterialBtn buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor blueColor];
        btn.frame = CGRectMake(OriginBtnCellX + index * (OriginBtnXGap + MaterialBtnWidth), maxTitleLabelY + (index / 4 + 1) * OriginBtnYGap, MaterialBtnWidth, MaterialBtnHeight);
        maxBtnY = CGRectGetMaxY(btn.frame);
        btn.selected = (arrayCount - 1 == index);
        [self.contentView addSubview:btn];
    }
    
    NSString *detailText = @"如果您上传的材料有特殊的译法，请务必在本下栏中注明。如果有钢印描述不清，请注明钢印文字";
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(OriginBtnCellX, maxBtnY + OriginBtnCellY, Screen_Width - 2 * OriginBtnCellX, [detailText heightForFont:firstTitleLabel.font width:Screen_Width - 2 * OriginBtnCellX])];
    detailLabel.numberOfLines = 0;
    detailLabel.text = detailText;
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.font = firstTitleLabel.font;
    [self.contentView addSubview:detailLabel];
    
    UITextField *detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMinX(secondTitleLabel.frame), CGRectGetMaxY(detailLabel.frame) + OriginBtnCellY, Screen_Width - 2 * AdaptedWidth(CGRectGetMinX(secondTitleLabel.frame)), 75 /2)];
    detailTextField.placeholder = @"请输入需要备注的信息";
    [self.contentView addSubview:detailTextField];

}
@end
