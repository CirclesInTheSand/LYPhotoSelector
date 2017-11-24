//
//  OnlineSectionHeaderView.h
//  LYPhotoSelector
//
//  Created by company on 17/10/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"

@interface OnlineSectionHeaderView : UITableViewHeaderFooterView
@property (nonatomic ,copy)NSString *titleString; /**<标题文字*/
- (instancetype)initWithModel:(MaterialModel *)materialModel;
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier model:(MaterialModel *)materialModel;
@end
