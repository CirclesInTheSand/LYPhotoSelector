//
//  UIScrollView+MPAdjustment.m
//  PINEChinaFilm
//
//  Created by PINE on 2017/9/22.
//  Copyright © 2017年 PINE. All rights reserved.
//

#import "UIScrollView+MPAdjustment.h"
#import <objc/runtime.h>

@implementation UIScrollView (MPAdjustment)

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel{
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return NO;
    
    class_addMethod(self, originalSel, class_getMethodImplementation(self, originalSel), method_getTypeEncoding(originalMethod));
    class_addMethod(self,
                    newSel,
                    class_getMethodImplementation(self, newSel),
                    method_getTypeEncoding(newMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, originalSel),
                                   class_getInstanceMethod(self, newSel));
    return YES;
}

+ (void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleInstanceMethod:@selector(initWithFrame:) with:@selector(swizzleInitWithFrame:)];
    });
}

- (instancetype)swizzleInitWithFrame:(CGRect)frame{
    
    UIScrollView * obj= (UIScrollView *)[self swizzleInitWithFrame:frame];
    if (obj) {
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 11.0) {
            if (@available(iOS 11.0, *)) {
             obj.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    }
    return obj;
    
}

@end
