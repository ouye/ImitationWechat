//
//  LLUtils+Video.h
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLUtils.h"
@import AVFoundation;

@interface LLUtils (Video)


/**
 *  将Apple视频录制的格式MOV转换为MP4格式
 *  @movUrl  视频路径地址  @completeCallback 转换成功后的 MP4位置回调
 */
+ (void)convertVideoFromMOVToMP4:(NSURL *)movUrl
                        complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback;


/**
 *  获取视频时长
 *  @return 单位秒 @videoPath 视频路径地址
 */
+ (CGFloat)getVideoLength:(NSString *)videoPath;


/**
 *  获取视频显示尺寸
 *  @param videoPath 视频文件文件路径
 *  @return 视频宽高
 */
+ (CGSize)getVideoSize:(NSString *)videoPath;


/**
 * 获取视频缩略图
 * @param videoPath 视频文件文件路径
 */
+ (UIImage *)getVideoThumbnailImage:(NSString *)videoPath;


/**
 * 用户录制的视频压缩 异步压缩  （压缩成MP4）
 * @param videoPath         视频文件文件路径
 *        removeMOVFile     是否删除原文件视频
 *        savePath          压缩后保存视频路径
 */
+ (void)compressVideoForSend:(NSURL *)videoURL
               removeMOVFile:(BOOL)removeMOVFile
                saveFilePath:(NSString*)savePath
                  okCallback:(void (^)(NSString *mp4Path))okCallback
              cancelCallback:(void (^)())cancelCallback
                failCallback:(void (^)())failCallback;


//系统相册中视频压缩
+ (void)compressVideoAssetForSend:(AVURLAsset *)videoAsset
                       okCallback:(void (^)(NSString *mp4Path))okCallback
                   cancelCallback:(void (^)())cancelCallback
                     failCallback:(void (^)())failCallback
                  successCallback:(void (^)(NSString *mp4Path))successCallback;






@end
