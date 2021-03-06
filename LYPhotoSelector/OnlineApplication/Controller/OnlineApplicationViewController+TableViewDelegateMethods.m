//
//  OnlineApplicationViewController+TableViewDelegateMethods.m
//  LYPhotoSelector
//
//  Created by Ivan Wu on 2017/11/27.
//  Copyright © 2017年 Calvix. All rights reserved.
//

#import "OnlineApplicationViewController+TableViewDelegateMethods.h"

@implementation OnlineApplicationViewController (TableViewDelegateMethods)
#pragma mark -- UITableView DataSource&&Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AdaptedHeight(40);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 0) return AdaptedHeight(120);
    return AdaptedHeight(24);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MaterialModel *model = self.dataSource[section];
    OnlineSectionHeaderView *headerView = (OnlineSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if(!headerView){
        headerView = [[OnlineSectionHeaderView alloc] initWithReuseIdentifier:@"headerView" model:model];
    }
    headerView.titleString = model.cellTitle;
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *clearView = [[UIView alloc] init];
    UIView *bgWhiteView = [[UIView alloc] init];
    [clearView addSubview:bgWhiteView];
    bgWhiteView.backgroundColor = [UIColor whiteColor];
    [bgWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, AdaptedHeight(8), 0));
    }];
    
    if(section == 0){
        return self.sectionFooterView;
    }
    return clearView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
    CredentialsModel *credential = model.credentialsArray[indexPath.row];
    CGFloat originHeight = 0;
    CGFloat integerBtnDistanceY = (Screen_Width - AdaptedWidth(63))/4.0 + AdaptedHeight(10);
    
    
    NSInteger linePhotoCount = credential.photoModelsArray.count;
    if(linePhotoCount == credential.maximumPhotoNum){//已达最大数量
        linePhotoCount -= 1;
    }
    originHeight += (linePhotoCount / 4 * integerBtnDistanceY);
    
    originHeight += AdaptedHeight(124);//349
    
    return originHeight;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    MaterialModel *model = self.dataSource[section];
    
    return model.credentialsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MaterialModel *model = self.dataSource[indexPath.section];
    CredentialsModel *credentialModel = model.credentialsArray[indexPath.row];
    
    UITableViewMaterialCell *onlineCell = [tableView dequeueReusableCellWithIdentifier:onlineCellIdentifier];
    onlineCell.delegate = self;
    [onlineCell fillCellWithModel:credentialModel];
    
    return onlineCell;
}
#pragma mark -- MaterialCellProtocol
#pragma mark --  MaterialCellProtocol
- (void)didClickAddBtn:(MaterialBtn *)btn{
    
    PhotoModel *selectedPhotoModel = btn.photoModel;
    
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    CredentialsModel *subMaterial = materialModel.credentialsArray[selectedPhotoModel.credentialsSection];
    
    NSMutableArray *photosArray = subMaterial.photoModelsArray;
    if(subMaterial.maximumPhotoNum <= photosArray.count){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"照片数量已达上限" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:true completion:nil];
        return;
    }
    self.availablePhotoNum = subMaterial.maximumPhotoNum - subMaterial.photoModelsArray.count;
    [self callSystemPhotoLibraryWithMaterialBtn:btn];
}

- (void)didClickShowBtn:(MaterialBtn *)btn{
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    PhotoModel *selectedPhotoModel = btn.photoModel;
    NSInteger indexOfPhotoModel = selectedPhotoModel.photoRow;
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    NSMutableArray *photosArray = (materialModel.credentialsArray[selectedPhotoModel.credentialsSection]).photoModelsArray;
    
    MJPhotoBrowser *browser  = [[MJPhotoBrowser alloc]init];
    NSMutableArray *photos = [NSMutableArray array];
    for (NSInteger index = 0 ; index < photosArray.count; index++) {
        PhotoModel *photoModel = photosArray[index];
        MJPhoto *photo = [[MJPhoto alloc] init];
        
        UIImage *photoImage = photoModel.photoImageObject;
        
        
        photo.image = photoImage;
        //设置来源于哪一个UIImageView
        photo.srcImageView = btn.bgImageView;
        
        [photos addObject:photo];
        
    }
    browser.photos = photos;
    
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = indexOfPhotoModel;
    
    // 4.显示浏览器
    [browser show];
}

/**
 点击了删除按钮

 @param btn <#btn description#>
 */
- (void)didClickDeleteIcon:(MaterialBtn *)btn{
    
    PhotoModel *selectedPhotoModel = btn.photoModel;
    NSInteger indexOfPhotoModel = selectedPhotoModel.photoRow;
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    NSMutableArray *photosArray = (materialModel.credentialsArray[selectedPhotoModel.credentialsSection]).photoModelsArray;
    [photosArray removeObjectAtIndex:indexOfPhotoModel];
    //
    //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:materialModel.modelType];
    //    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:btn.photoModel.credentialsSection inSection:btn.photoModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
@end
