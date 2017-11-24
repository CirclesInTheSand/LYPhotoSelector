//
//  OnlineConst.h
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#ifndef OnlineConst_h
#define OnlineConst_h

#import "NSString+YYQExtension.h"
//屏幕高度
#define Screen_Height      [[UIScreen mainScreen] bounds].size.height
//屏幕宽度
#define Screen_Width       [[UIScreen mainScreen] bounds].size.width

//适配不同屏幕尺寸
#define kScreenWidthRatio  (Screen_Width / 375.0)
#define kScreenHeightRatio (Screen_Height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
//适配不同屏幕尺寸的默认字体
#define DEFAULT_FONT(size) kFontSize(size)
#define kFontSize(R)     [UIFont systemFontOfSize:AdaptedWidth(R)]
#define kBlodFontSize(R) [UIFont boldSystemFontOfSize:AdaptedWidth(R)]
//分辨率
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

//RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)
#endif /* OnlineConst_h */
