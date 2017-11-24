//
//  UITableViewMaterialCell.m
//  LYPhotoSelector
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
#import "SubMaterialView.h"

@interface UITableViewMaterialCell ()<PhotoBtnClickProtocol>
@property (nonatomic,strong) MaterialModel *materialModel; /** 材料模型 */
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
- (void)reuseCellWithModel:(MaterialModel *)model{
    self.materialModel = model;
    for(id view in self.contentView.subviews){
        if([view isKindOfClass:[SubMaterialView class]]){
            SubMaterialView *materialView = view;
            return;
        }
    }
    
    UIView *subMaterialContentView = nil;
    CGFloat maxContentY = 0;
    for(NSInteger index = 0; index < model.subMaterialArray.count; index ++){
        SubMaterialModel *subModel = model.subMaterialArray[index];
        SubMaterialView *materialView = [[SubMaterialView alloc] initWithSubMaterialModel:subModel modelType:model.modelType];
        materialView.frame = CGRectMake(0, maxContentY, Screen_Width, [materialView estimatedHeight]);
        materialView.delegate = self;
        subMaterialContentView = materialView;
        if(subMaterialContentView){
            maxContentY = CGRectGetMaxY(subMaterialContentView.frame);
        }
        
        [self.contentView addSubview:materialView];
    }
}

- (void)fillCellWithModel:(MaterialModel *)model{
    self.materialModel = model;
    //清除以前的视图
    for(id view in self.contentView.subviews){
        if([view isKindOfClass:[UILabel class]] || [view isKindOfClass:[SubMaterialView class]] || [view isKindOfClass:[UITextField class]]){
            [view removeFromSuperview];
        }
    }
    
    UIView *subMaterialContentView = nil;
    CGFloat maxContentY = 0;
    for(NSInteger index = 0; index < model.subMaterialArray.count; index ++){
        SubMaterialModel *subModel = model.subMaterialArray[index];
        SubMaterialView *materialView = [[SubMaterialView alloc] initWithSubMaterialModel:subModel modelType:model.modelType];
        materialView.frame = CGRectMake(0, maxContentY, Screen_Width, [materialView estimatedHeight]);
        materialView.delegate = self;
        subMaterialContentView = materialView;
        if(subMaterialContentView){
            maxContentY = CGRectGetMaxY(subMaterialContentView.frame);
        }

        [self.contentView addSubview:materialView];
    }
   

    if(model.modelType >=  MaterialModelType_EventOne)return;
    NSString *detailText = @"备注 : 如果您上传的材料有特殊的译法，请务必在本下栏中注明。如果有钢印描述不清，请注明钢印文字";
    NSMutableAttributedString *firstAttributedString = [[NSMutableAttributedString alloc] initWithString:detailText];
    CGFloat maximunHeight = AdaptedHeight(18);

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if([detailText heightForFont:kFontSize(12) width:(Screen_Width - AdaptedWidth(2 * OriginBtnCellX))] > maximunHeight){
        [paragraphStyle setLineSpacing:9];
    }else{
        [paragraphStyle setLineSpacing:0];
    }

    [firstAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailText.length)];

    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 2 * OriginBtnCellX, 0)];
    detailLabel.numberOfLines = 0;
    detailLabel.attributedText = firstAttributedString;
    detailLabel.textColor = RGB(51, 51, 51);
    detailLabel.font = kFontSize(12);
    [detailLabel sizeToFit];
    detailLabel.frame = CGRectMake(OriginBtnCellX, maxContentY + OriginBtnCellY, Screen_Width - 2 * OriginBtnCellX, detailLabel.frame.size.height);
    [self.contentView addSubview:detailLabel];

    UITextField *detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(OriginBtnCellX, CGRectGetMaxY(detailLabel.frame) + OriginBtnCellY, Screen_Width - 2 * OriginBtnCellX, 25)];
    detailTextField.placeholder = @"  请输入需要备注的信息";
    detailTextField.font = kFontSize(12);
    detailTextField.backgroundColor = RGB(245, 245, 245);
    detailTextField.layer.borderColor = RGB(179, 179, 179).CGColor;
    detailTextField.layer.borderWidth = SINGLE_LINE_WIDTH;
    [self.contentView addSubview:detailTextField];

}

- (CGSize)sizeThatFits:(CGSize)size{
    MaterialModel *model = self.materialModel;
    CGFloat originHeight = 0;
    CGFloat integerBtnDistanceY = (Screen_Width - AdaptedWidth(63))/4.0 + AdaptedHeight(10);
    
    for(NSInteger index = 0; index < model.subMaterialArray.count; index ++){
        SubMaterialModel *subMaterialModel = model.subMaterialArray[index];
        NSInteger linePhotoCount = subMaterialModel.photoModelsArray.count;
        if(linePhotoCount == subMaterialModel.maximumPhotoNum){//已达最大数量
            linePhotoCount -= 1;
        }
        originHeight += (linePhotoCount / 4 * integerBtnDistanceY);
    }
    
    switch (model.modelType) {
        case 0:
        {
            originHeight += AdaptedHeight(349);
            break;
        }
        case 1:
        {
            originHeight += AdaptedHeight(279);
            break;
        }
        case 2:
        {
            originHeight += AdaptedHeight(279);
            break;
        }
        default:
            break;
    }
    return CGSizeMake(self.frame.size.width, originHeight);
}
@end
