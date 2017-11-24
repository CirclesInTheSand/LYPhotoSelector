//
//  MaterialModel.h
//  LYPhotoSelector
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class SubMaterialModel;
@class PhotoModel;
typedef NS_ENUM(NSInteger, MaterialModelType) {
    MaterialModelType_Public = 0, /**< 公共材料 */
    MaterialModelType_EventOne, /**< 事项一材料 */
    MaterialModelType_EventTwo /**< 事项二材料 */
};

typedef NS_ENUM(NSInteger, MaterialBtnType) {
    MaterialBtnType_FirstLine, /**< 第一行材料 */
    MaterialBtnType_SecondLine, /**< 第二行材料 */
};
@interface MaterialModel : NSObject

@property (nonatomic,copy) NSString *cellTitle; /**< 标题文本信息*/
@property (nonatomic,assign) MaterialModelType modelType; /**< 模型类型 */
@property (nonatomic,strong) NSMutableArray <SubMaterialModel *>*subMaterialArray;
@property (nonatomic ,copy)NSString *remarksString; /**<相关备注信息*/
@end

@interface SubMaterialModel : NSObject
@property (nonatomic ,copy) NSString *title; /**<文本标题*/
@property (nonatomic ,strong) NSMutableArray *photoModelsArray;
@property (nonatomic ,assign) NSInteger maximumPhotoNum;
@property (nonatomic ,assign) MaterialBtnType photoBtnType;
@end

@interface PhotoModel : NSObject
//@property (nonatomic,strong) NSString *imageStr; /**< 存储的image对象的字符串*/
@property (nonatomic,strong) UIImage *photoImageObject;
@property (nonatomic,assign) MaterialBtnType type; /*0 -> 类型一照片，1->类型二照片*/
- (instancetype)initWithUIImage:(UIImage *)image type:(MaterialBtnType)type;
@end
