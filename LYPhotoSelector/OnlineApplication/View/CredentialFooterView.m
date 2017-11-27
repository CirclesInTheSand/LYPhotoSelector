//
//  CredentialFooterView.m
//  LYPhotoSelector
//
//  Created by Ivan Wu on 2017/11/27.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "CredentialFooterView.h"
#import "OnlineConst.h"

@implementation CredentialFooterView
- (instancetype)init{
    if(self = [super init]){
        UIView *bgFooterView = self;
        bgFooterView.backgroundColor = [UIColor whiteColor];
        NSString *detailText = @"备注 : 如果您上传的材料有特殊的译法，请务必在本下栏中注明。如果有钢印描述不清，请注明钢印文字";
        NSMutableAttributedString *firstAttributedString = [[NSMutableAttributedString alloc] initWithString:detailText];
        CGFloat maximunHeight = AdaptedHeight(18);
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        if([detailText heightForFont:kFontSize(12) width:(Screen_Width - AdaptedWidth(2 * AdaptedWidth(16)))] > maximunHeight){
            [paragraphStyle setLineSpacing:9];
        }else{
            [paragraphStyle setLineSpacing:0];
        }
        
        [firstAttributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, detailText.length)];
        
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 2 * AdaptedWidth(16), 0)];
        detailLabel.numberOfLines = 0;
        detailLabel.attributedText = firstAttributedString;
        detailLabel.textColor = RGB(51, 51, 51);
        detailLabel.font = kFontSize(12);
        [detailLabel sizeToFit];
        detailLabel.frame = CGRectMake(AdaptedWidth(16), AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), detailLabel.frame.size.height);
        [bgFooterView addSubview:detailLabel];
        
        UITextField *detailTextField = [[UITextField alloc] initWithFrame:CGRectMake(AdaptedWidth(16), CGRectGetMaxY(detailLabel.frame) + AdaptedHeight(16), Screen_Width - 2 * AdaptedWidth(16), AdaptedHeight(25))];
        detailTextField.placeholder = @"  请输入需要备注的信息";
        detailTextField.font = kFontSize(12);
        detailTextField.backgroundColor = RGB(245, 245, 245);
        detailTextField.layer.borderColor = RGB(179, 179, 179).CGColor;
        detailTextField.layer.borderWidth = SINGLE_LINE_WIDTH;
        [bgFooterView addSubview:detailTextField];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(detailTextField.frame) + AdaptedHeight(8), Screen_Width, AdaptedHeight(8))];
        bottomLine.backgroundColor = RGB(240, 240, 240);
        [bgFooterView addSubview:bottomLine];
    }
    return self;
}
@end
