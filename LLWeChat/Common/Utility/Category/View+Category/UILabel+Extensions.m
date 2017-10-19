//
//  UILabel+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/7.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "UILabel+Extensions.h"

@implementation UILabel (Extensions)

/**
 * （前提 使用frame原生代码设置约束的问题） 为了解决 比如 标注label时 如果标注的上一个控件label与下一个控件label时 标注的是字体与字体的的间距
 *  设置label高 即可把 字体高当 label高即可，如果标注的是 控件与控件呢 label高 入font 17 label高多少， 随便设置一个？然后sizeToFit 是可以
 *  不过 这样的话 label固定宽就变了 为了解决 原生代码 这个疼点 由此设计这个方法， 即也是 通过该方法（ 原理 sizeToFit后） 得到高当作label高
 **/
/**
 *   获取sizeToFit后label的高
 */
- (CGFloat)getHeightBysizeToFit{
    return [self getSizeBysizeToFit].height;
}

/**
 *   获取sizeToFit后label的CGSize  前提是 label赋文字之后才有效
 */
- (CGSize)getSizeBysizeToFit{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    label.text = self.text;
    label.font = self.font;
    label.numberOfLines = self.numberOfLines;
    [label sizeToFit];
    return label.size;
}



/**
 *   改变字符串中具体某字符串的颜色
 *   @param change          需要改变颜色的字
 *   @param allColor        其他文字的颜色
 *   @param markColor       需要改变文字的颜色
 *   @param fontSize        需要改变文字的字体大小
 */
- (void)changeString:(NSString *)change andAllColor:(UIColor *)allColor andMarkColor:(UIColor *)markColor andMarkFondSize:(float)fontSize{
    NSString *tempStr = self.text;
    NSMutableAttributedString *strAtt = [[NSMutableAttributedString alloc] initWithString:tempStr];
    [strAtt addAttribute:NSForegroundColorAttributeName value:allColor range:NSMakeRange(0, [strAtt length])];
    NSRange markRange = [tempStr rangeOfString:change];
    [strAtt addAttribute:NSForegroundColorAttributeName value:markColor range:markRange];
    [strAtt addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue" size:fontSize] range:markRange];
    self.attributedText = strAtt;
}

@end
