//
//  TestJSObject.m
//  TestJSOC
//
//  Created by 西游 on 7/25/15.
//  Copyright (c) 2015 com.xiyou. All rights reserved.
//

#import "AppBridge.h"

@implementation AppBridge
- (void)setSelectedRegion:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}
- (void)getSelectedRegion:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)popToSelectedController:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getUserState:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}
- (void)closeLoading
{
    [self performSelectorWithDic:nil withSEL:_cmd];
}

- (void)close:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)openUrl:(NSString *)dic;
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getCurrentPosition:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getCurrentRegion:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getTabbarDic:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)makeCall:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)showCinemaMap:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)launchAppPay:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)shareToWeixinFriendsWithData:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)changeRightButColor:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)setUserInfo:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)changeBuyTicketType:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)topBarVisible:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

-(void)tellAppAppleSuccess:(NSString *)dic{

    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)isCancelMobilePay:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)clearCache
{
    [self performSelectorWithDic:nil withSEL:_cmd];
}

- (void)backButtonEnabled:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)networkStatusChanged:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)videoPlayTitleShow:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getCurrentVersion:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)updateBuyTicketInterfaceIfNecessary:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)changeCartGoods:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)flexBoxRefresh:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)openUrlWithSafari:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)saveImageToPhotos:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)shareBigImageToWeiXin:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)replaceHead:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)changeMsgCount:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)multiplePicUploads:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)onCountEvent:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)getCacheSize:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)buttonClicked:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}

- (void)changeButtonStatus:(NSString *)dic
{
    [self performSelectorWithDic:dic withSEL:_cmd];
}


#pragma mark -- performSelectorOnDelegate


- (void)performSelectorWithDic:(NSString *)dic
{
    NSString *methodString = [NSThread callStackSymbols][1];
    NSInteger startIndex = [methodString rangeOfString:@"-["].location;
    NSInteger endIndex = [methodString rangeOfString:@"] +"].location;
    NSString *selectorString = [[[methodString substringWithRange:NSMakeRange(startIndex, endIndex - startIndex)] componentsSeparatedByString:@"AppBridge "] lastObject];
    SEL methodSelector = NSSelectorFromString(selectorString);
    if([self isDelegateInvalideWithSEL:methodSelector])return;
    if(!dic)
    {
        IMP imp = [(id)self.delegate methodForSelector:methodSelector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.delegate, methodSelector);
        return;
    }
    
    IMP imp = [(id)self.delegate methodForSelector:methodSelector];
    void (*func)(id, SEL, NSString*) = (void *)imp;
    func(self.delegate, _cmd, dic);
}

/**
 代理执行相关方法

 @param selector 方法名称
 @param dic 方法所带参数
 */
- (void)performSelectorWithDic:(NSString *)dic withSEL:(SEL)selector
{
    if([self isDelegateInvalideWithSEL:selector])return;
    if(!dic)
    {
        IMP imp = [(id)self.delegate methodForSelector:selector];
        void (*func)(id, SEL) = (void *)imp;
        func(self.delegate, selector);
        return;
    }
    
    IMP imp = [(id)self.delegate methodForSelector:selector];
    void (*func)(id, SEL, NSString*) = (void *)imp;
    func(self.delegate, _cmd, dic);
}


/**
 方法是否被代理响应

 @param selector 方法名称
 @return 是否被代理响应的布尔值
 */
- (BOOL)isDelegateInvalideWithSEL:(SEL)selector
{
    if(self.delegate == nil || [((id)self.delegate) isKindOfClass:[AppBridge class]])return true;
    if(![(NSObject *)self.delegate respondsToSelector:selector])
    {
        NSLog(@"Error:The %@ doesn't contain method :%@",[(NSObject *)self.delegate class],NSStringFromSelector(selector));
        return true;
    }
    return false;
}
@end
