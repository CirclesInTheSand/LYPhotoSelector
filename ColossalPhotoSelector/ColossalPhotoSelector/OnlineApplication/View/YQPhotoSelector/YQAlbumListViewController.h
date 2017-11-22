//
//  YQAlbumListViewController.h
//  PhotoSelect
//
//  Created by MyMacbook on 16/4/29.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"

//回调block
typedef void (^YQPhotoResult)(NSMutableArray * responseImageObjects, NSMutableArray *responsePHAssetObjects);

@interface YQAlbumListViewController : UITableViewController

@property (nonatomic ,strong)NSMutableArray *albums;

@property (nonatomic ,assign)NSInteger maxCount;

@property (nonatomic ,strong)NSArray *selectedPhotos;

- (void)showPhotoListViewController:(YQPhotoResult)result;

@end
