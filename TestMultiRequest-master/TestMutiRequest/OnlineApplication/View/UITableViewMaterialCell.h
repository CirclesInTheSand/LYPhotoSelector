//
//  UITableViewMaterialCell.h
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"

@protocol MaterialCellProtocol

- (void)didClickAddBtn;
- (void)didClickDeleteBtn;
@end

@interface UITableViewMaterialCell : UITableViewCell

@property (nonatomic,weak)id <MaterialCellProtocol>delegate;

- (void)fillCellWithModel:(MaterialModel *)model;
@end
