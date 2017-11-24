//
//  PhotoPickCollectionViewCell.m
//  PhotoSelect
//
//  Created by PINE on 16/5/3.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import "PhotoPickCollectionViewCell.h"

@interface PhotoPickCollectionViewCell ()

@property (nonatomic ,strong)UIImageView *assetImageView;


@end

@implementation PhotoPickCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
     
        [self setUpViews];
        
    }
    return self;
}

-(void)setUpViews{
    
    _assetImageView = [[UIImageView alloc]initWithFrame:self.contentView.frame];
    _assetImageView.contentMode = UIViewContentModeScaleAspectFill;
    _assetImageView.clipsToBounds = YES;
    [self.contentView addSubview:self.assetImageView];
    
    CGFloat picViewSize = ([UIScreen mainScreen].bounds.size.width - 3) / 4;
    
    CGFloat btnSize = picViewSize / 4;
    
    _selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(picViewSize - btnSize - 5, 5, btnSize, btnSize)];
    _selectBtn.userInteractionEnabled = false;
    [self.contentView addSubview:_selectBtn];
    
}

//记录按钮选中和非选中的状态
-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(PHAsset *)assetItem
{
    if ([selectArray containsObject:assetItem]) {
        _selectBtn.selected = YES;
        [_selectBtn setImage:[UIImage imageNamed:@"YQPhotoSelector.bundle/select_yes"] forState:UIControlStateNormal];
    }else{
        _selectBtn.selected = NO;
        [_selectBtn setImage:[UIImage imageNamed:@"YQPhotoSelector.bundle/select_no"] forState:UIControlStateNormal];
    }
}

-(void)fillCellWithAsset:(PHAsset *)asset{
    
    
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(200,200) contentMode:PHImageContentModeDefault options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        
        if (result == nil) {
    
            self.assetImageView.image = [UIImage imageNamed:@"YQPhotoSelector.bundle/no_data"];
            
        }else{
            
            self.assetImageView.image = result;
        }
        
    }];
    
}



@end
