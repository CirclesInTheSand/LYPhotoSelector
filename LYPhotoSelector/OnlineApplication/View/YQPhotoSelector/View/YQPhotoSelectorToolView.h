//
//  YQPhotoSelectorToolView.h
//  PhotoSelect
//
//  Created by Mopon on 16/5/3.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YQPhotoSelectorToolViewDelegate <NSObject>

-(void)didClickedDoneBtn:(UIButton *)doneBtn;

@end

@interface YQPhotoSelectorToolView : UIView

-(void)setSelectCount:(NSInteger)count;

@property (nonatomic ,weak)id<YQPhotoSelectorToolViewDelegate> delegate;

@end
