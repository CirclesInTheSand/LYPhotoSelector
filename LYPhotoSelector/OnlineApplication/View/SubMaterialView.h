//
//  SubMaterialView.h
//  LYPhotoSelector
//
//  Created by company on 26/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"
@class MaterialBtn;

@protocol PhotoBtnClickProtocol
- (void)btnClickedInSubMaterialView:(MaterialBtn *)btn;
- (void)deleteIconClicked:(MaterialBtn *)btn;
@end

@interface SubMaterialView : UIView

@property (nonatomic,weak) id <PhotoBtnClickProtocol>delegate;

- (instancetype)initWithSubMaterialModel:(CredentialsModel *)submaterialModel modelType:(MaterialModelType)materialType;
- (CGFloat)estimatedHeight;
- (void)reuseModel:(CredentialsModel *)submaterialModel modelType:(MaterialModelType)materialType;
@end
