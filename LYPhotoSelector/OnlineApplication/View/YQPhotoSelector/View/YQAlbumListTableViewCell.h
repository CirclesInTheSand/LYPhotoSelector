//
//  YQAlbumListTableViewCell.h
//  PhotoSelect
//
//  Created by PINE on 16/4/29.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"


@interface YQAlbumListTableViewCell : UITableViewCell

-(void)loadPhotoListData:(PHAssetCollection *)assetItem;

@end
