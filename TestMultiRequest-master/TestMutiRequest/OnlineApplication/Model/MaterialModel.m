//
//  MaterialModel.m
//  TestMutiRequest
//
//  Created by company on 25/9/2017.
//  Copyright © 2017 Calvix. All rights reserved.
//

#import "MaterialModel.h"

@implementation MaterialModel
- (NSMutableArray *)firstTypeMaterial{
    if(_firstTypeMaterial == nil){
        _firstTypeMaterial = [NSMutableArray array];
    }
    return _firstTypeMaterial;
}

- (NSMutableArray *)secondTypeMaterial{
    if(_secondTypeMaterial == nil){
        _secondTypeMaterial = [NSMutableArray array];
    }
    return _secondTypeMaterial;
}

@end
@implementation PhotoModel

@end
