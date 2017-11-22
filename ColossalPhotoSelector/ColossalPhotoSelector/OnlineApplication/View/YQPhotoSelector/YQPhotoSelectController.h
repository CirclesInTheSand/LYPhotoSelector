//
//  YQPhotoSelectController.h
//  PhotoSelect
//
//  Created by MyMacbook on 16/4/29.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"

@interface YQPhotoSelectController : NSObject

-(void)showInController:(UIViewController *)controller result:(YQPhotoResult)result;

@property (nonatomic,assign)NSInteger maxCount;
@property (nonatomic,strong)NSArray *selectedPhotos;
@end
