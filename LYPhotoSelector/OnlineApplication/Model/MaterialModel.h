//
//  MaterialModel.h
//  LYPhotoSelector
//
//  Created by Pine on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class CredentialsModel;
@class PhotoModel;
typedef NS_ENUM(NSInteger, MaterialModelType) {
    MaterialModelType_Public = 0, /**< 公共材料 */
    MaterialModelType_EventOne, /**< 事项一材料 */
};

@interface MaterialModel : NSObject

@property (nonatomic,copy) NSString *cellTitle; /**< 标题文本信息*/
@property (nonatomic,assign) MaterialModelType modelType; /**< 材料模型类型 */
@property (nonatomic,strong) NSMutableArray <CredentialsModel *>*credentialsArray;
@property (nonatomic ,copy)NSString *remarksString; /**<相关备注信息*/

/**
 材料模型的初始化

 @param materialType 材料模型
 @return 材料模型
 */
- (instancetype)initWithMaterialType:(MaterialModelType)materialType;

/**
 添加证件模型

 @param credentialsModel 传入证件模型
 */
- (void)addCredentialsModel:(CredentialsModel *)credentialsModel;
@end

@interface CredentialsModel : NSObject
@property (nonatomic ,copy) NSString *title; /**<文本标题*/
@property (nonatomic ,strong) NSMutableArray *photoModelsArray;
@property (nonatomic ,assign) NSInteger maximumPhotoNum;
@property (nonatomic ,assign) NSInteger credentialsSection;
@property (nonatomic,assign) MaterialModelType modelType;
/**
 初始化证件模型

 @param title 标题
 @param maxPhotoNum 限制最大证件数量
 @return 证件
 */
- (instancetype)initWithTitle:(NSString *)title maxPhotoNum:(NSInteger)maxPhotoNum materialType:(MaterialModelType)materialType;
@end

@interface PhotoModel : NSObject
//@property (nonatomic,strong) NSString *imageStr; /**< 存储的image对象的字符串*/
@property (nonatomic,strong) UIImage *photoImageObject;
@property (nonatomic,assign) NSInteger photoRow; /**< 我是第photoRow个照片,珍爱生命远离tag*/
@property (nonatomic,assign) NSInteger credentialsSection;
@property (nonatomic,assign) MaterialModelType modelType;
- (instancetype)initWithUIImage:(UIImage *)image credentialsSection:(NSInteger)credentialSection materialType:(MaterialModelType)materialType;
@end
