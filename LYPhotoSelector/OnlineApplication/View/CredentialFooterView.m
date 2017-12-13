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
        
        UILabel *detailLabel = [[UILabel alloc] init];
        
        detailLabel.numberOfLines = 0;
        detailLabel.attributedText = firstAttributedString;
        detailLabel.textColor = RGB(51, 51, 51);
        detailLabel.font = kFontSize(12);
        [bgFooterView addSubview:detailLabel];
        
        /**< 详细文字布局 */
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidth(16));
            make.top.mas_equalTo(AdaptedHeight(16));
            make.right.mas_equalTo(self).offset(-AdaptedWidth(16));
        }];
        
        
        UITextField *detailTextField = [[UITextField alloc] init];
        detailTextField.placeholder = @"  请输入需要备注的信息";
        detailTextField.font = kFontSize(12);
        detailTextField.backgroundColor = RGB(245, 245, 245);
        detailTextField.layer.borderColor = RGB(179, 179, 179).CGColor;
        detailTextField.layer.borderWidth = SINGLE_LINE_WIDTH;
        [bgFooterView addSubview:detailTextField];
        
        /**< 编辑框布局 */
        [detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(AdaptedWidth(16));
            make.top.mas_equalTo(detailLabel.mas_bottom).offset(AdaptedHeight(16));
            make.right.mas_equalTo(self).mas_equalTo(-AdaptedWidth(16));
            make.height.mas_equalTo(AdaptedHeight(25));
        }];
        
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = RGB(240, 240, 240);
        [bgFooterView addSubview:bottomLine];
        
        /**< 底线布局 */
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(detailTextField.mas_bottom).offset(AdaptedHeight(8 * 2));
            make.width.mas_equalTo(self);
            make.height.mas_equalTo(AdaptedHeight(8));
        }];
    }
    return self;
}
@end
