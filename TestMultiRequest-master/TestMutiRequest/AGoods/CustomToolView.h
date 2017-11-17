//
//  CustomToolView.h
//  TestMutiRequest
//
//  Created by company on 12/6/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ToolViewBlcok)(NSInteger index);
@interface CustomToolView : UIView
/** 标题数组 */
@property (nonatomic ,strong) NSArray *titiles;

/** 标题字体 */
@property (nonatomic ,strong) UIFont *titleFont;

/** 线在的宽度 */
@property (nonatomic ,assign) CGFloat lineWidth;
/** 滑动 */
@property (nonatomic ,assign) BOOL animation;
/** 目前选中的按钮的index */
@property (nonatomic,assign) NSInteger currentIndex;/**<< <#description#> */
- (instancetype)initWithTitles:(NSArray *)titles font:(CGFloat)font;

- (void)didClickBtnWithHandle:(ToolViewBlcok)handle;


- (void)changeButtonIndexTo:(NSInteger)buttonIndex;
- (void)btnClick:(UIButton *)sender;
@end
