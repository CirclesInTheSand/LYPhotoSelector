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
    if(section == 0)return AdaptedHeight(120);
    return AdaptedHeight(8);
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
    if(section == 0){
        return self.sectionFooterView;
        
    }
    return nil;
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
    
    originHeight += AdaptedHeight(140);//349
    
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
    self.currentSelectedMaterialBtn = btn;
    [self callSystemPhotoLibrary];
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

- (void)didClickDeleteIcon:(MaterialBtn *)btn{
    PhotoModel *selectedPhotoModel = btn.photoModel;
    NSInteger indexOfPhotoModel = selectedPhotoModel.photoRow;
    MaterialModel *materialModel = self.dataSource[selectedPhotoModel.modelType];
    NSMutableArray *photosArray = (materialModel.credentialsArray[selectedPhotoModel.credentialsSection]).photoModelsArray;
    [photosArray removeObjectAtIndex:indexOfPhotoModel];
    //
    //    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:materialModel.modelType];
    //    [self.applicationTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.applicationTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.currentSelectedMaterialBtn.photoModel.credentialsSection inSection:self.currentSelectedMaterialBtn.photoModel.modelType]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}
@end
