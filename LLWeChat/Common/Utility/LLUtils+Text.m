//
//  LLUtils+Text.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/14.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLUtils+Text.h"

@implementation LLUtils (Text)


/*
 * 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 */
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString
{
    if (aString.length == 0)
        return nil;
    
    //首字符就是字母
    unichar C = [aString characterAtIndex:0];
    if((C<= 'Z' && C>='A') || (C <= 'z' && C >= 'a')) {
        //转化为大写拼音
        NSString *pinYin = [[aString substringToIndex:1] capitalizedString];
        //获取并返回首字母
        return pinYin;
    }
    
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:[aString substringToIndex:1]];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}


//获取拼音
+ (NSString *)pinyinOfString:(NSString *)aString
{
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
    //获取并返回首字母
    return pinYin;
}

@end
