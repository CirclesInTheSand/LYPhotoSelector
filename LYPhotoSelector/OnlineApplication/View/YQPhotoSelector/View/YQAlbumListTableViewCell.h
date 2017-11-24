//
//  YQAlbumListTableViewCell.h
//  PhotoSelect
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"


@interface YQAlbumListTableViewCell : UITableViewCell

-(void)loadPhotoListData:(PHAssetCollection *)assetItem;

@end
