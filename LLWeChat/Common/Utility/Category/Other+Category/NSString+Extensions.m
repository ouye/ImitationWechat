//
//  NSString+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "NSString+Extensions.h"

@implementation NSString (Extensions)

/**
 *  是不是包含中文汉字
 */
-(BOOL)isContainsChinese{
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:self]) {
        return YES;
    }
    return NO;
}


/**
 *  判断单个字符 是不是小写字母
 */
- (BOOL)isLowerLetter{
    
    NSString *str=self;
    if (str.length == 0 ) {
        return NO;
    }
    // 判断长度大于8位后再接着判断是否同时包含数字和字符
    NSString * regex = @"[a-z]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL result = [pred evaluateWithObject:str];
    return result;
}


/**
 *  判断单个字符 是不是大写字母
 */
- (BOOL)isCatipalLetter{
    NSString *str = self;
    if (str.length == 0 ) {
        return NO;
    }
    if ([str characterAtIndex:0] >= 'A' && [str characterAtIndex:0] <= 'Z') {
        return YES;
    }
    return NO;
}

/**
 *  判断全部字符 是不是小写字母
 */
- (BOOL)isAllLowerLetter{

    NSString *str = self;
    if (str.length == 0 ) {
        return NO;
    }
    int num = (int)str.length;
    int k = 0;
    for (int i = 0; i < num; i ++) {
        if ([str characterAtIndex:i] >= 'a' && [str characterAtIndex:0] <= 'z') {
            k ++;
        }
    }
    
    if (k == num) return YES;
    return NO;
}

/**
 *  判断全部字符 是不是大写字母
 */
- (BOOL)isAllCatipalLetter{

    NSString *str = self;
    if (str.length == 0 ) {
        return NO;
    }
    int num = (int)str.length;
    int k = 0;
    for (int i = 0; i < num; i ++) {
        if ([str characterAtIndex:i] >= 'A' && [str characterAtIndex:0] <= 'Z') {
            k ++;
        }
    }
    
    if (k == num) return YES;
    return NO;
}

/**
 *  只能为中文
 */
-(BOOL)onlyInputChineseCharacters{
    NSString *inputString =@"[\u4e00-\u9fa5]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",inputString];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}


/**
 *  只能为数字
 */
- (BOOL)onlyInputTheNumber{
    NSString *numString =@"[0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numString];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *  只能为小写
 */
- (BOOL)onlyInputLowercaseLetter{
    NSString *regex =@"[a-z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *  只能为大写
 */
- (BOOL)onlyInputACapital{
    NSString *regex =@"[A-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *  允许大小写
 */
- (BOOL)inputCapitalAndLowercaseLetter{
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL  result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *   允许含大小写或数字(不限字数)
 */
- (BOOL)inputLettersOrNumbers{
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL  result = [predicate evaluateWithObject:self];
    return result;
}

/**
 *   允许含大小写或数字(限字数)
 */
-(BOOL)inputNumberOrLetters {
    NSString *userNameRegex =@"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL  result = [userNamePredicate evaluateWithObject:self];
    return result;
}


#pragma --------  字符转化等各种处理 ---------
/**
 *   将汉字转换成 拼音
 */
- (NSString *)stringConvertPinyin{
    NSString  *aString = self;
    if (aString.length == 0)
        return nil;
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回拼音
    return pinYin;
}

@end
