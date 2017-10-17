//
//  LLUtils+File.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNUtils+File.h"

@implementation HNUtils (File)

/*
 *  在该目录下有三个文件夹：Documents、Library、temp以及一个.app包！
 */
+ (NSString *)homeDirectory {
    return NSHomeDirectory();
}

/*
 *  Documents   只有用户生成的文件、应用程序不能重新创建的文件，应该保存在<Application_Home>/Documents 目录下面，并将通过iCloud自动备份。
 */
+ (NSString *)documentDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    return docDir;
}

/*
 * tmp:只是临时使用的数据应该保存到<Application_Home>/tmp 文件夹。尽管 iCloud 不会备份这些文件，但在应用在使用完这些数据之后要注意随时删除，避免占用用户设备的空间
 */
+ (NSString *)tmpDirectory {
    NSString *tmpDir = NSTemporaryDirectory();
    return tmpDir;
}

/*
 *  Library 下的 Caches 文件路径  用于存储缓存文件路径
 */
+ (NSString *)cacheDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    
    return cachesDir;
}


/*
 *  创建文件路径
 */
+ (NSURL *)createFolderWithName:(NSString *)folderName inDirectory:(NSString *)directory {
    NSString *path = [directory stringByAppendingPathComponent:folderName];
    NSURL *folderURL = [NSURL URLWithString:path];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error;
        [fileManager createDirectoryAtPath:path
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:&error];
        if (!error) {
            return folderURL;
        }else {
            NSLog(@"创建文件失败 %@", error.localizedFailureReason);
            return nil;
        }
        
    }
    return folderURL;
}


/*
 *  删除某个文件目录下的所有 文件及文件夹
 */
+ (BOOL)removeFileAtPath:(NSString *)folderPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:folderPath]) {
        NSError *error = nil;
        [fileManager removeItemAtPath:folderPath error:&error];
        if (error) {
            NSLog(@"failed to remove file, error:%@.", error);
            return NO;
        }else{
            return YES;
        }
    }
    return YES;
}


/**
 *  返回文件大小，单位为字节
 */

// 需要注意:iOS中1G == 1000Mb ==1000 * 1000kb == 1000 * 1000 * 1000b
+ (long long)getFileSize:(NSString *)folderPath num:(long long)a{
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    unsigned long long size = a;
    
    BOOL isDir;
    BOOL exist =  [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];  // 判断路径是否存在
    if (!exist) return 0;
    
    if (isDir) {  // isDir == YES 是文件夹
        NSArray* array = [fileManager contentsOfDirectoryAtPath:folderPath error:nil]; //列出目录内容

        for(int i = 0; i<[array count]; i++){
            NSString *fullPath = [folderPath stringByAppendingPathComponent:[array objectAtIndex:i]];
            
            BOOL exist =  [fileManager fileExistsAtPath:folderPath isDirectory:&isDir];  // 判断路径是否存在
            if (isDir) {
                size += [HNUtils getFileSize:fullPath num:size];
            }
            
            size += [HNUtils getFileSize:fullPath num:size];
        }
    }else{
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:folderPath error:nil];
        CGFloat  fileSize = attrs.fileSize;
        return  fileSize*0.001;
    }
    return size;
}


+ (NSString *)messageThumbnailDirectory {
    static NSString *_dataPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataPath = [NSString stringWithFormat:@"%@/%@", [self documentDirectory], MessageThumbnailDirectory];
    });
    
    NSFileManager *fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:_dataPath]){
        NSError *error;
        [fm createDirectoryAtPath:_dataPath
      withIntermediateDirectories:YES
                       attributes:nil
                            error:&error];
    }
    
    return _dataPath;
}

@end
