//
//  MaterialModel.m
//  LYPhotoSelector
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "MaterialModel.h"

#define StandardMaterialPhotoNum 8

@implementation MaterialModel
- (NSMutableArray *)subMaterialArray{
    if(_subMaterialArray == nil){
        _subMaterialArray = [NSMutableArray array];
    }
    return _subMaterialArray;
}
@end

@implementation SubMaterialModel

- (NSMutableArray *)photoModelsArray{
    if(!_photoModelsArray){
        _photoModelsArray = [NSMutableArray array];
    }
    return _photoModelsArray;
}

- (NSInteger)maximumPhotoNum{
    if(_maximumPhotoNum <= 0)return StandardMaterialPhotoNum;
    return _maximumPhotoNum;
}

@end

@implementation PhotoModel
- (instancetype)initWithUIImage:(UIImage *)image type:(MaterialBtnType)type{
    self = [super init];
    if(self){
        self.photoImageObject = image;
        self.type = type;
    }
    return self;
}
@end
