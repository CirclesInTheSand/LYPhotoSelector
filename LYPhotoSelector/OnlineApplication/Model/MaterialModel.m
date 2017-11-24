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
- (instancetype)initWithMaterialType:(MaterialModelType)materialType{
    self = [super init];
    if(self){
        self.modelType = materialType;
    }
    return self;
}

- (void)addCredentialsModel:(CredentialsModel *)credentialsModel{
    /**< 添加credentialsModel */
    [self.credentialsArray addObject:credentialsModel];
    /**< 注释这是第几个section的credentials */
    credentialsModel.credentialsSection = [self.credentialsArray indexOfObject:credentialsModel];
}


- (NSMutableArray *)credentialsArray{
    if(_credentialsArray == nil){
        _credentialsArray = [NSMutableArray array];
    }
    return _credentialsArray;
}

@end

@implementation CredentialsModel
- (instancetype)initWithTitle:(NSString *)title maxPhotoNum:(NSInteger)maxPhotoNum materialType:(MaterialModelType)materialType;{
    self = [super init];
    if(self){
        self.title = title;
        self.maximumPhotoNum = maxPhotoNum;
        self.modelType = materialType;
    }
    return self;
}

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
- (instancetype)initWithUIImage:(UIImage *)image credentialsSection:(NSInteger)credentialSection materialType:(MaterialModelType)materialType{
    self = [super init];
    if(self){
        self.photoImageObject = image;
        self.credentialsSection = credentialSection;
        self.modelType = materialType;
    }
    return self;
}
@end
