//
//  YQPhotoSelectController.m
//  PhotoSelect
//
//  Created by MyMacbook on 16/4/29.
//  Copyright © 2016年 MyMacbook. All rights reserved.
//

#import "YQPhotoSelectController.h"


@interface YQPhotoSelectController ()

@property (nonatomic ,strong)YQAlbumListViewController *albumListVc;

@property (nonatomic ,strong)YQPhotoPickViewController *photoPickVC;

@end

@implementation YQPhotoSelectController


- (void)showInController:(UIViewController *)controller result:(YQPhotoResult)result{
    
//    权限判断
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (status == PHAuthorizationStatusDenied) {//相册权限未开启
        
        //相册权限未开启
        [self showAlertViewToController:controller];
        
    }else if (status == PHAuthorizationStatusNotDetermined){
        //相册进行授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            //授权后直接打开照片库
            if (status == PHAuthorizationStatusAuthorized){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showController:controller result:result];
                });
                
            }
        }];
        
    }else if (status == PHAuthorizationStatusAuthorized){
        [self showController:controller result:result];
    }

}

- (void)showController:(UIViewController *)vc result:(YQPhotoResult)result{

    YQAlbumListViewController *album = [[YQAlbumListViewController alloc]init];
    if(self.selectedPhotos != nil && self.selectedPhotos.count > 0)
    {
        album.selectedPhotos = self.selectedPhotos;
    }
    
    UINavigationController *nav= [[UINavigationController alloc]initWithRootViewController:album];
    
    album.albums = [[YQPhotoHelper shareYQPhotoHelper] GetPhotoListDatas];
    
    album.title = @"相册";
    if (album.albums.count >0) {
        
        album.maxCount = self.maxCount;
    }

    [album setValue:result forKey:@"resultHandel"];
    [vc presentViewController:nav animated:YES completion:^{
        
    }];
}

- (void)showAlertViewToController:(UIViewController *)controller
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:[NSString stringWithFormat:@"请在iPhone的“设置->隐私->照片”开启%@访问你的手机相册",app_Name] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
        
    }];
    
    [alert addAction:action1];
    [controller presentViewController:alert animated:YES completion:nil];
}


@end
