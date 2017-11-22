//
//  SubMaterialView.h
//  ColossalPhotoSelector
//
//  Created by MyMacbook on 26/9/2017.
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

- (instancetype)initWithSubMaterialModel:(SubMaterialModel *)submaterialModel modelType:(MaterialModelType)materialType;
- (CGFloat)estimatedHeight;
- (void)reuseModel:(SubMaterialModel *)submaterialModel modelType:(MaterialModelType)materialType;
@end
