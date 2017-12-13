//
//  SubMaterialView.m
//  LYPhotoSelector
//
//  Created by Pine on 26/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "SubMaterialView.h"
#import "OnlineConst.h"
#import "MaterialBtn.h"

#define OriginBtnCellX AdaptedWidth(16)
#define OriginBtnCellY AdaptedHeight(16)
#define OriginBtnXGap AdaptedWidth(10)
#define OriginBtnYGap AdaptedHeight(10)
#define MaterialBtnWidth (Screen_Width - AdaptedWidth(63))/4.0
#define MaterialBtnHeight MaterialBtnWidth

@interface SubMaterialView ()
@property (nonatomic, assign) CGFloat maximumHeight;
@end

@implementation SubMaterialView
- (instancetype)initWithSubMaterialModel:(CredentialsModel *)submaterialModel modelType:(MaterialModelType)materialType
{
    self = [super init];
    if(self){
        NSMutableAttributedString *firstAttributedString = [[NSMutableAttributedString alloc] initWithString:submaterialModel.title];
        CGFloat maximunHeight = AdaptedHeight(18);
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        if([submaterialModel.title heightForFont:kFontSize(12) width:Screen_Width] > maximunHeight){
            [paragraphStyle setLineSpacing:9];
        }else{
            [paragraphStyle setLineSpacing:0];
        }
        
        [firstAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, submaterialModel.title.length)];
        
        UILabel *firstTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        firstTitleLabel.attributedText = firstAttributedString;
        firstTitleLabel.font = kFontSize(12);
        firstTitleLabel.textColor = RGB(51, 51, 51);
        firstTitleLabel.numberOfLines = 0;
        [firstTitleLabel sizeToFit];
    
        [self addSubview:firstTitleLabel];
        [firstTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(OriginBtnCellX);
            make.top.mas_equalTo(AdaptedHeight(15));
            make.width.mas_equalTo(self);
        }];
        [self addMutipuleBtnWithSubMaterialModel:submaterialModel type:materialType lastLabel:firstTitleLabel];
    }
    return self;
}

- (void)addMutipuleBtnWithSubMaterialModel:(CredentialsModel *)model type:(MaterialModelType)type lastLabel:(UILabel *)descLabel{
    UIButton *lastBtn = nil;
    NSInteger totalCount = model.photoModelsArray.count + 1; /**< item总个数,+1 是因为有一个+号按钮*/
    NSInteger maxRowCount = 4; /**< 每行最大个数 */
    CGFloat leadSpacing = OriginBtnCellX; /**< 左边缘距离 */
    CGFloat tailSpacing = OriginBtnCellX; /**< 右边缘距离 */
    CGSize itemSize = CGSizeMake(MaterialBtnWidth, MaterialBtnHeight);
    CGFloat fixedHorizontalSpacing = ([UIScreen mainScreen].bounds.size.width - leadSpacing - tailSpacing - maxRowCount * itemSize.width) / (CGFloat)(maxRowCount - 1); /**< item之间固定水平间隙 */
    CGFloat fixedVerticalSpacing = OriginBtnYGap; /**< item之间固定垂直间隙 */
    
    for (NSInteger itemIndex = 0; itemIndex < totalCount; itemIndex++) {
        
        if(itemIndex == totalCount - 1){
            /**< 如果是最后一个,并且最大数量已经达到了上限，那么不需要选中按钮 */
            if(model.maximumPhotoNum == totalCount - 1){
                break;
            }
        }

        MaterialBtn *button = [MaterialBtn buttonWithType:UIButtonTypeCustom];
        button.selected = !(totalCount - 1 == itemIndex);
        if(itemIndex != totalCount - 1){ //如果不是最后一个按钮，才给加背景图.
            button.backgroundColor = [UIColor clearColor];
            PhotoModel *photoModel = model.photoModelsArray[itemIndex];
            [button setBackgroundImage:photoModel.photoImageObject forState:UIControlStateNormal];
        }
        
        /**< 是不是最后一个都给点击事件,根据按钮的selected来判断点击事件*/
        [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button.deleteBtn addTarget:self action:@selector(deleteIconClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.photoModel.modelType = type;
        button.photoModel.credentialsSection = model.credentialsSection;
        button.photoModel.photoRow = itemIndex;

        [self addSubview:button];
        
        CGFloat colTop = (fixedVerticalSpacing + itemIndex / maxRowCount * (fixedVerticalSpacing + itemSize.height));
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
    
            make.size.mas_equalTo(itemSize);
            make.top.mas_equalTo(descLabel.mas_bottom).offset(colTop);
        
            if (itemIndex % maxRowCount == 0) {
                make.left.mas_equalTo(leadSpacing);
            }else{
                make.left.equalTo(lastBtn.mas_right).offset(fixedHorizontalSpacing);
            }
            
            if (itemIndex % maxRowCount == maxRowCount - 1) {
                make.right.mas_equalTo(self).offset(-tailSpacing);
            }
            
        }];
        lastBtn = button;
        self.maximumHeight = AdaptedHeight(35) + colTop + MaterialBtnHeight;
    }
}

- (void)deleteIconClicked:(UIButton *)sender{
    [self.delegate deleteIconClicked:(MaterialBtn *)sender.superview];
}

- (void)btnClicked:(MaterialBtn *)sender{
    [self.delegate btnClickedInSubMaterialView:sender];
}

- (CGFloat)estimatedHeight{
    return self.maximumHeight;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
