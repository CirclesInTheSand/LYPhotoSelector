//
//  YQPhotoHelper.m
//  PhotoSelect
//
//  Created by Mopon on 16/4/28.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQPhotoHelper.h"

@interface YQPhotoHelper ()

@property (nonatomic ,assign)NSInteger count;

@end

@implementation YQPhotoHelper

+(instancetype)shareYQPhotoHelper{

    
    static dispatch_once_t pre = 0;
    __strong static id _shareObject = nil;
    dispatch_once(&pre, ^{
        
        _shareObject = [[self alloc]init];
    });
    
    return _shareObject;
}

-(NSMutableArray *)GetPhotoListDatas
{
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    
    [dataArray addObject:[smartAlbumsFetchResult objectAtIndex:0]];
    
    PHFetchResult *smartAlbumsFetchResult1 = [PHAssetCollection fetchTopLevelUserCollectionsWithOptions:fetchOptions];
    
    for (PHAssetCollection *sub in smartAlbumsFetchResult1)
    {
        [dataArray addObject:sub];
    }
    
    return dataArray;
}

-(PHFetchResult *)GetFetchResult:(PHAssetCollection *)assetCollection
{
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    return fetchResult;
    
}

-(NSMutableArray *)GetPhotoAssets:(PHFetchResult *)fetchResult
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (PHAsset *asset in fetchResult) {
        //只添加图片类型资源，去除视频类型资源
        //当mediaType == 2时，这个资源则为视频资源
        if (asset.mediaType == 1) {
            [dataArray addObject:asset];
        }
        
    }
    return dataArray;
}

-(PHFetchResult *)GetCameraRollFetchResul
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc]init];
    
    PHFetchResult *smartAlbumsFetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:fetchOptions];
    
    
    PHFetchResult *fetch = [PHAsset fetchAssetsInAssetCollection:[smartAlbumsFetchResult objectAtIndex:0] options:nil];
    return fetch;
}

-(void)GetImageObject:(id)asset complection:(void (^)(UIImage *, BOOL isDegraded))complection
{
    if ([asset isKindOfClass:[PHAsset class]]) {
        PHAsset *phAsset = (PHAsset *)asset;
        
        CGFloat photoWidth = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
        CGFloat multiple = [UIScreen mainScreen].scale;
        CGFloat pixelWidth = photoWidth * multiple;
        CGFloat pixelHeight = pixelWidth / aspectRatio;
        
        [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            
            BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
            if (downloadFinined) {
                if (complection) complection(result,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
            }
        }];
        
    }
    
}

@end
