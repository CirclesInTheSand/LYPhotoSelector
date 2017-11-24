//
//  UITableViewMaterialCell.h
//  LYPhotoSelector
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"
@class MaterialBtn;

@protocol MaterialCellProtocol

- (void)didClickAddBtn:(MaterialBtn *)btn;
- (void)didClickShowBtn:(MaterialBtn *)btn;
- (void)didClickDeleteIcon:(MaterialBtn *)btn;
@end

@interface UITableViewMaterialCell : UITableViewCell

@property (nonatomic,weak)id <MaterialCellProtocol>delegate;

- (void)fillCellWithModel:(CredentialsModel *)model;
- (void)reuseCellWithModel:(MaterialModel *)model;
@end
