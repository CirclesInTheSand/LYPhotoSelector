//
//  YQAlbumListViewController.h
//  PhotoSelect
//
//  Created by PINE on 16/4/29.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"

//回调block
typedef void (^YQPhotoResult)(NSMutableArray <UIImage *>* responseImageObjects, NSMutableArray <PHAsset *>*responsePHAssetObjects);

@interface YQAlbumListViewController : UITableViewController

@property (nonatomic ,strong)NSMutableArray *albums;

@property (nonatomic ,assign)NSInteger maxCount;

@property (nonatomic ,strong)NSArray *selectedPhotos;

- (void)showPhotoListViewController:(YQPhotoResult)result;

@end
