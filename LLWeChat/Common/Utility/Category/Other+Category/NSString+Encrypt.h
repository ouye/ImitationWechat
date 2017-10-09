//
//  NSString+Encrypt.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#pragma ---- 加密相关 ----

#import <Foundation/Foundation.h>

@interface NSString (Encrypt)

- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;

@end
