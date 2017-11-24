//
//  PhotoPickCollectionViewCell.h
//  PhotoSelect
//
//  Created by Mopon on 16/5/3.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"


@interface PhotoPickCollectionViewCell : UICollectionViewCell

-(void)fillCellWithAsset:(PHAsset *)asset;

-(void)selectBtnStage:(NSMutableArray *)selectArray existence:(PHAsset *)assetItem;

@property (nonatomic ,strong)NSIndexPath *indexPath;

@property (nonatomic ,strong)UIButton *selectBtn;

@end
