//
//  NSString+PhoneEmail.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PhoneEmail)

/**
 *  是不是电话号码
 */
-(BOOL)isPhoneNumber;


/**
 *  是不是电话号码
 */
-(BOOL)isEmailAdress;

@end
