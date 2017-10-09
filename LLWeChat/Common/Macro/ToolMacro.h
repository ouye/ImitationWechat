//
//  ToolMacro.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/23.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#ifndef ToolMacro_h
#define ToolMacro_h

/*** weakSelf 防止循环引用  ***/
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF if (!weakSelf) return; \
__strong typeof(weakSelf) strongSelf = weakSelf


//有效的设置：在工程Bulid Settings的other C Flags的Debug中加入-DDEBUG就可以在代码中的任何位置使用DLog了。
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%@%s-" fmt),  NSStringFromClass([self class]),__PRETTY_FUNCTION__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


/***  判断代理是否存在 是否可以执行代理 ***/
#define SAFE_SEND_MESSAGE(obj, msg) if ((obj) && [(obj) respondsToSelector:@selector(msg)])

/** 提示用语 **/
#define NOT_SUPPORT_ALERT  [MBProgressHUD showMessage:@"暂不支持该功能"]


#endif /* ToolMacro_h */
