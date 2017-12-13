//
//  UITableViewMaterialCell.m
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
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
#import "SubMaterialView.h"

@interface UITableViewMaterialCell ()<PhotoBtnClickProtocol>
@property (nonatomic,strong) CredentialsModel *credentialModel; /** 材料模型 */
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
- (void)btnClickedInSubMaterialView:(MaterialBtn *)btn{
    if(btn.selected){
        [self.delegate didClickShowBtn:btn];
    }else{
        [self.delegate didClickAddBtn:btn];
    }
}

- (void)deleteIconClicked:(MaterialBtn *)btn{
    [self.delegate didClickDeleteIcon:btn];
}

#pragma mark -- 模型赋值
- (void)fillCellWithModel:(CredentialsModel *)model{
    self.credentialModel = model;
    //清除以前的视图
    for(id view in self.contentView.subviews){
        if([view isKindOfClass:[SubMaterialView class]]){
            [view removeFromSuperview];
        }
    }
    
    SubMaterialView *materialView = [[SubMaterialView alloc] initWithSubMaterialModel:model modelType:model.modelType];
    materialView.delegate = self;
    [self.contentView addSubview:materialView];
    
    [materialView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(0);
        make.width.mas_equalTo(self);
        make.height.mas_equalTo([materialView estimatedHeight]);
    }];
}
@end
