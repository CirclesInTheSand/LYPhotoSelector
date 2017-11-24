//
//  YQPhotoPickViewController.h
//  PhotoSelect
//
//  Created by PINE on 16/4/29.
//  Copyright © 2016年 PINE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"

//回调block
typedef void (^YQPhotoResult)(NSMutableArray * responseImageObjects, NSMutableArray *responsePHAssetObjects);

@interface YQPhotoPickViewController : UIViewController

@property (nonatomic ,strong)PHAssetCollection *assetCollection;

@property (nonatomic ,assign)NSInteger maxCount;

@property (nonatomic, strong)NSArray *selectedPhotos;

@property (nonatomic ,copy) YQPhotoResult Result;

@end
