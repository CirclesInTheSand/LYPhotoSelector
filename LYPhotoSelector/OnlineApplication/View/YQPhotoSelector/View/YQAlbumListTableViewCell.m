//
//  YQAlbumListTableViewCell.m
//  PhotoSelect
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import "YQAlbumListTableViewCell.h"

@interface YQAlbumListTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UILabel *albumTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *photoCountLabel;

@end

@implementation YQAlbumListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)loadPhotoListData:(PHAssetCollection *)collectionItem
{
    if ([collectionItem isKindOfClass:[PHAssetCollection class]]) {
        PHFetchResult *group = [PHAsset fetchAssetsInAssetCollection:collectionItem options:nil];
        
        [[PHImageManager defaultManager] requestImageForAsset:group.lastObject
                                                   targetSize:CGSizeMake(200,200)
                                                  contentMode:PHImageContentModeDefault
                                                      options:nil
                                                resultHandler:^(UIImage *result, NSDictionary *info) {
                                                    if (result == nil) {
                                                        self.albumImageView.image = [UIImage imageNamed:@"YQPhotoSelector.bundle/no_data"];
                                                    }else{
                                                        self.albumImageView.image = result;
                                                    }
                                                }];
        
        
        PHAssetCollection *titleAsset = collectionItem;
        
        if ([titleAsset.localizedTitle isEqualToString:@"Camera Roll"]) {
            self.albumTitleLabel.text = @"相机胶卷";
        }else{
            self.albumTitleLabel.text = [NSString stringWithFormat:@"%@",titleAsset.localizedTitle];
        }
        
        
        self.photoCountLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)group.count];
    }
}

@end
