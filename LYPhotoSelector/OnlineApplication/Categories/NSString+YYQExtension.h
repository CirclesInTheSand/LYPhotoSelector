//
//  NSString+YYQExtension.h
//
//  Created by 尹永奇 on 16/6/15.
//  Copyright © 2016年 尹永奇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YYQExtension)

/**
 *  获取UUID字符串
 */
+ (NSString *)stringWithUUID;

/**
 *  根据文件名读取本地文件转换成utf-8编码的字符串
 *
 *  @param resourceName 文件名
 */
+ (NSString *)stringWithResourceName:(NSString *)resourceName;

/**
 *  计算文字的尺寸
 *
 *  @param font 文字的字体
 *  @param size 文字的最大尺寸
 *
 *  @return 文字尺寸
 */
- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

/**
 *  计算文字的宽度
 *
 *  @param font 文字的字体
 *
 *  @return 文字的宽度
 */
- (CGFloat)widthForFont:(UIFont *)font;

/**
 *  根据指定的宽度，计算文字的高度
 *
 *  @param font  文字的字体
 *  @param width 文字的指定宽度
 *
 *  @return 文字的高度
 */
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

/**
 *  判断字符串是否不为空（其中包含字符串为nil  @"" @" " @"\n"）
 
    返回NO说明字符串为空  YES说明字符串不为空
 */
- (BOOL)isNotBlank;

- (BOOL)isBlank;

/**
 检索字符串中相同字符串的所有range

 @param subStr 子字符串
 @param string 完整字符串
 @return 返回NSRange字符串的数组。 需要用NSRangeFromString(rangeArray[i])​提取出NSRange
 */
- (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string;

/**
 是否是纯数字
 */
- (BOOL)isPureNumandCharacters;
//密码限制6-20位 密码+数字
- (BOOL)checkPassWord;
//昵称
-(BOOL)checkNickName;
//判断手机号
- (BOOL)valiMobile;
//判断验证码6位纯数字
- (BOOL)checkCode;
//验证卡密码6-12位出数字密码
- (BOOL)checkCardPwd;

/**
 是否是中影限制的手机号

 @return 返回布尔值
 */
- (BOOL)isZYMobilePhoneNum;
/**
 从字符串里面截取电话号码数组

 @return 返回电话号码数组
 */
- (NSArray *)getTeleStringArrayFromTextString;

+(BOOL)isContainsTwoEmoji:(NSString *)string;

@end
