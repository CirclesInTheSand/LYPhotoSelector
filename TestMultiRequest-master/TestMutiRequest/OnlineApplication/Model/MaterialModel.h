//
//  MaterialModel.h
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MaterialModelType) {
    MaterialModelType_Public, /**< 公共材料 */
    MaterialModelType_EventOne, /**< 事项一材料 */
    MaterialModelType_EventTwo /**< 事项二材料 */
};


@interface MaterialModel : NSObject
@property (nonatomic,assign) MaterialModelType *modelType; /**< 模型类型 */
@property (nonatomic,strong) NSMutableArray *firstTypeMaterial; /** 类型一数组 */
@property (nonatomic,strong) NSMutableArray *secondTypeMaterial; /** 类型二数组 */
@property (nonatomic ,copy)NSString *remarksString; /**<相关备注信息*/
@end


@interface PhotoModel : NSObject
@property (nonatomic,strong) NSString *imageStr; /**< 存储的image对象的字符串*/
@property (nonatomic,assign)NSInteger type; /*0 -> 类型一照片，1->类型二照片*/
@property (nonatomic,copy) NSString *ID;
@end
