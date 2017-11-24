//
//  NSString+YYQExtension.m
//
//  Created by 尹永奇 on 16/6/15.
//  Copyright © 2016年 尹永奇. All rights reserved.
//

#import "NSString+YYQExtension.h"

@implementation NSString (YYQExtension)

+ (NSString *)stringWithUUID{
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)stringWithResourceName:(NSString *)resourceName{
    NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:resourceName ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode{
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
        
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
//#pragma clang diagnostic pop
        
        NSDictionary *attribute = @{NSFontAttributeName: font};
         result = [self boundingRectWithSize:size options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font{

    return [self sizeForFont:font size:CGSizeMake(MAXFLOAT, MAXFLOAT) mode:NSLineBreakByWordWrapping].width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width{

    return [self sizeForFont:font size:CGSizeMake(width, MAXFLOAT) mode:NSLineBreakByWordWrapping].height;
}


/**
 从字符串里面截取电话号码数组
 
 @return 返回电话号码数组
 */
- (NSArray *)getTeleStringArrayFromTextString
{
    NSMutableArray *mutablaArray = [NSMutableArray array];
    NSMutableString *mutableString = [NSMutableString string];
    for(NSInteger i = 0; i < self.length; i ++)
    {
        unichar selectedSingleStr = [self characterAtIndex:i];
        BOOL currentStrIsNum = isdigit(selectedSingleStr) || selectedSingleStr == [@"-" characterAtIndex:0];
        
        if(i == self.length - 1)
        {
            if(currentStrIsNum)
            {
                [mutableString appendString:[NSString stringWithFormat:@"%c",selectedSingleStr]];
                [mutablaArray addObject:mutableString];
            }
            break;
        }
        
        unichar afterStr = [self characterAtIndex:i + 1];
        
        
        BOOL laterStrIsNum = isdigit(afterStr) || afterStr == [@"-" characterAtIndex:0];
        
        if(currentStrIsNum && laterStrIsNum)
        {
            [mutableString appendString:[NSString stringWithFormat:@"%c",selectedSingleStr]];
        }
        else if (currentStrIsNum && !laterStrIsNum)
        {
            [mutableString appendString:[NSString stringWithFormat:@"%c",selectedSingleStr]];
            [mutablaArray addObject:mutableString];
            mutableString = [NSMutableString string];
        }
        
    }
    
    //对不包含-的号码进一步处理
    for(NSInteger index = 0; index < mutablaArray.count; index ++)
    {
        NSMutableString *mutStr = mutablaArray[index];
        if(index + 1 < mutablaArray.count)
        {
            NSString *numberPrefix = [mutStr componentsSeparatedByString:@"-"][0];
            NSMutableString *afterStr = mutablaArray[index + 1];
            if([afterStr rangeOfString:@"-"].location == NSNotFound)
            {
                [afterStr replaceCharactersInRange:NSMakeRange(0, 0) withString:[numberPrefix stringByAppendingString:@"-"]];
                continue;
            }
        }
    }
    
    return mutablaArray;
}

- (NSData *)dataValue{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

-(BOOL)checkPassWord
{
    //6-20位数字和字母组成
    NSString *regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6，20}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}
-(BOOL)checkNickName
{
    //2-10位数字和字母组成和中文
    NSString *regex = @"^[0-9a-zA-Z\u4e00-\u9fa5]{1,10}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}
-(BOOL)checkCode
{
    //6-20位数字和字母组成
    NSString *regex = @"^[0-9]{6}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if ([pred evaluateWithObject:self]) {
        return YES ;
    }else
        return NO;
}

- (BOOL)checkCardPwd {
    
    if(self.length >= 6){
        return YES;
    }else
    {
        return NO;
    }
}

- (BOOL)isBlank{

    return ![self isNotBlank];
}

- (BOOL)isNotBlank{
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}


- (NSArray *)rangeOfSubString:(NSString *)subStr inString:(NSString *)string {
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString *string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for (int i = 0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject:NSStringFromRange(range)];
            
        }
        
    }
    
    return rangeArray;
    
}

- (BOOL)isPureNumandCharacters
{
    NSString *str = self;
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str.length > 0)
    {
        return NO;
    }
    return YES;
}
//判断手机号
- (BOOL)valiMobile{
    BOOL y;
    if (self.length < 11)
    {
        return NO;
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:self];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:self];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:self];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            y = YES;
        }else{
            y = NO;
        }
    }
    return y;
}

- (BOOL)isZYMobilePhoneNum
{
    //不是字符串，不符合规则
    if(![self isKindOfClass:[NSString class]])return false;
    //小于11位，不符合规则
    if(self.length < 11)return false;
    //不是纯数字，不符合规则
    if(![self isPureNumandCharacters])return false;
    NSString *firstStrNum = [self substringToIndex:1];
    return ([firstStrNum isEqualToString:@"1"] && self.length == 11);
}

+ (BOOL)isContainsTwoEmoji:(NSString *)string
{
    __block BOOL isEomji = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         const unichar hs = [substring characterAtIndex:0];
         //         NSLog(@"hs++++++++%04x",hs);
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     isEomji = YES;
                 }
                 //                 NSLog(@"uc++++++++%04x",uc);
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3|| ls ==0xfe0f) {
                 isEomji = YES;
             }
             //             NSLog(@"ls++++++++%04x",ls);
         } else {
             if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
                 isEomji = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 isEomji = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 isEomji = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 isEomji = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
                 isEomji = YES;
             }
         }
         
     }];
    return isEomji;
}
@end
