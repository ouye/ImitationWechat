//
//  NSString+Extensions.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extensions)

#pragma --------  正则判断处理 ---------
/**
 *  是不是包含中文汉字
 */
-(BOOL)isContainsChinese;


/**
 *  判断单个字符 是不是小写字母
 */
- (BOOL)isLowerLetter;


/**
 *  判断单个字符 是不是大写字母
 */
- (BOOL)isCatipalLetter;


/**
 *  判断全部字符 是不是小写字母
 */
- (BOOL)isAllLowerLetter;


/**
 *  判断全部字符 是不是大写字母
 */
- (BOOL)isAllCatipalLetter;


/**
 *  只能为中文
 */
-(BOOL)onlyInputChineseCharacters;


/**
 *  只能为数字
 */
- (BOOL)onlyInputTheNumber;

/**
 *  只能为大写
 */
- (BOOL)onlyInputACapital;

/**
 *  允许大小写
 */
- (BOOL)inputCapitalAndLowercaseLetter;


/**
 *   允许含大小写或数字(不限字数)
 */
- (BOOL)inputLettersOrNumbers;

/**
 *   允许含大小写或数字(限字数) (注册 )
 */
-(BOOL)inputNumberOrLetters;


#pragma --------  字符转化等各种处理 ---------
/**
 *   将汉字转换成 拼音
 */
- (NSString *)stringConvertPinyin;

@end
