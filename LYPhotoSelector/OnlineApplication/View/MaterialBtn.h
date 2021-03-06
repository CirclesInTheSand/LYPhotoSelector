//
//  MaterialBtn.h
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialModel.h"


@interface MaterialBtn : UIButton
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIImageView *bgImageView; /**< 背景图片 */
@property (nonatomic, strong)PhotoModel *photoModel;
@end
