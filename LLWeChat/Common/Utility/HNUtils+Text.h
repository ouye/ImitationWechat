//
//  LLUtils+Text.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/14.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils.h"

@interface HNUtils (Text)

+ (CGFloat)widthForSingleLineString:(NSString *)text font:(UIFont *)font;


/*
 * 获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 */
+ (NSString *)firstPinyinLetterOfString:(NSString *)aString;

/*
 * 获取字符串的 拼音
 */
+ (NSString *)pinyinOfString:(NSString *)aString;


@end
