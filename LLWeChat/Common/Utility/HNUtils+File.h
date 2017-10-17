//
//  LLUtils+File.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils.h"

@interface HNUtils (File)

/*
 *  在该目录下有三个文件夹：Documents、Library、temp以及一个.app包！
 */
+ (NSString *)homeDirectory;

/* 
 *  Documents   只有用户生成的文件、应用程序不能重新创建的文件，应该保存在<Application_Home>/Documents 目录下面，并将通过iCloud自动备份。
 */
+ (NSString *)documentDirectory;


/*
 * tmp:只是临时使用的数据应该保存到<Application_Home>/tmp 文件夹。尽管 iCloud 不会备份这些文件，但在应用在使用完这些数据之后要注意随时删除，避免占用用户设备的空间
 */
+ (NSString *)tmpDirectory;

/*
 *  Library 下的 Caches 文件路径  用于存储缓存文件路径
 */
+ (NSString *)cacheDirectory;


/*
 *  创建文件路径
 */
+ (NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory;


/*
 *  删除某个文件目录下的所有 文件及文件夹
 */
+ (BOOL)removeFileAtPath:(NSString *)folderPath;


/**
 *  返回文件大小，单位为字节 // 需要注意:iOS中1G == 1000Mb ==1000 * 1000kb == 1000 * 1000 * 1000b
 */
+ (long long)getFileSize:(NSString *)folderPath num:(long long)a;



/*
 *  讲图片 保存到 文件路径下
 */
+ (void)writeImageAtPath:(NSString *)path image:(UIImage *)image;



+ (NSString *)messageThumbnailDirectory;


@end
