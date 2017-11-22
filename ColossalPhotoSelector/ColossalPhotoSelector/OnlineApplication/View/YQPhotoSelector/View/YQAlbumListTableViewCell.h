//
//  YQAlbumListTableViewCell.h
//  PhotoSelect
//
//  Created by MyMacbook on 16/4/29.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"


@interface YQAlbumListTableViewCell : UITableViewCell

-(void)loadPhotoListData:(PHAssetCollection *)assetItem;

@end
