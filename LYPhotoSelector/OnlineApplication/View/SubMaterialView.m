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
        firstTitleLabel.frame = CGRectMake(OriginBtnCellX, AdaptedHeight(15), Screen_Width, firstTitleLabel.frame.size.height);
        [self addSubview:firstTitleLabel];
        
        
        CGFloat maxTitleLabelY = CGRectGetMaxY(firstTitleLabel.frame) + OriginBtnYGap;
        CGFloat maxBtnY = 0;
        NSInteger arrayCount = submaterialModel.photoModelsArray.count + 1;
        for (NSInteger index = 0; index < arrayCount; index ++){
            
            if(index == arrayCount - 1){
                //如果是最后一个,并且最大数量已经达到了上限，那么不需要选中按钮
                if(submaterialModel.maximumPhotoNum == arrayCount - 1){
                    break;
                }
            }
            
            MaterialBtn *btn = [MaterialBtn buttonWithType:UIButtonTypeCustom];
            
            btn.frame = CGRectMake(OriginBtnCellX + index % 4 * (OriginBtnXGap + MaterialBtnWidth), maxTitleLabelY + (index / 4) * (OriginBtnYGap + MaterialBtnHeight), MaterialBtnWidth, MaterialBtnHeight);
            maxBtnY = CGRectGetMaxY(btn.frame);
            
            //不是最后一个则是选中状态
            btn.selected = !(arrayCount - 1 == index);
        
            if(index != arrayCount - 1){ //如果不是最后一个，赋值
                btn.backgroundColor = [UIColor clearColor];
                PhotoModel *photoModel = submaterialModel.photoModelsArray[index];
                [btn setBackgroundImage:photoModel.photoImageObject forState:UIControlStateNormal];
            }
            
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn.deleteBtn addTarget:self action:@selector(deleteIconClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.photoModel.modelType = materialType;
            btn.photoModel.credentialsSection = submaterialModel.credentialsSection;
            btn.photoModel.photoRow = index;
            [self addSubview:btn];
            self.maximumHeight = maxBtnY;
        }
    }
    return self;
}

- (void)reuseModel:(CredentialsModel *)submaterialModel modelType:(MaterialModelType)materialType{
    
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
