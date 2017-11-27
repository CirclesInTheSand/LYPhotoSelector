//
//  OnlineApplicationViewController.h
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineConst.h"
#import "UITableViewMaterialCell.h"
#import "OnlineSectionHeaderView.h"
#import "CredentialFooterView.h"
#import "MaterialBtn.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

static NSString *onlineCellIdentifier = @"onlineCell";

@interface OnlineApplicationViewController : UIViewController
@property (nonatomic,strong) NSMutableArray *dataSource; /**< tableView的数据源 */
@property (nonatomic,strong) CredentialFooterView *sectionFooterView; /**< 材料section的脚视图 */
@property (nonatomic,strong) MaterialBtn *currentSelectedMaterialBtn; /**< 目前选中的照片材料按钮 */
@property (nonatomic,assign) NSInteger availablePhotoNum; /**< row中的还可选择张数 */
@property (nonatomic,strong) UITableView *applicationTableView; /**< 应用的表视图 */

/**
 访问系统相册
 */
- (void)callSystemPhotoLibrary;
@end
