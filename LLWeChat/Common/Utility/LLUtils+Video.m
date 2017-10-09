//
//  LLUtils+Video.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/11.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "LLUtils+Video.h"

#define AlAsset_Library_Scheme @"assets-library"


@implementation LLUtils (Video)

/**
 *  将Apple视频录制的格式MOV转换为MP4格式
 *
 */
+ (void)convertVideoFromMOVToMP4:(NSURL *)movUrl complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:movUrl options:nil];
    [self convertVideoFromMOVAssetToMP4:avAsset complete:completeCallback];
}

+ (void)convertVideoFromMOVAssetToMP4:(AVURLAsset *)avAsset complete:(void (^)(NSString *mp4Path, BOOL finished))completeCallback {
    NSString *path;
    if ([avAsset.URL.scheme isEqualToString:AlAsset_Library_Scheme]) {
        path = avAsset.URL.query;
        if (path.length == 0) {
            completeCallback(nil, NO);
            return;
        }
        
    }else {
        path = avAsset.URL.path;
        if (!path || ![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            completeCallback(nil, NO);
            return;
        }
    }
    
    NSString *mp4Path = nil; //[NSString stringWithFormat:@"%@/%@.mp4", [LLUtils dataPath], [path md5]];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:mp4Path]) {
        if (completeCallback)
            completeCallback(mp4Path, YES);
        return;
    }
    
    NSURL *mp4Url;
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetMediumQuality]) {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]
                                               initWithAsset:avAsset
                                               presetName:AVAssetExportPresetMediumQuality];
        
        mp4Url = [NSURL fileURLWithPath:mp4Path];
        exportSession.outputURL = mp4Url;
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            BOOL finished = NO;
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                    NSLog(@"AVAssetExportSessionStatusFailed, error:%@.", exportSession.error);
                    break;
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"AVAssetExportSessionStatusCancelled.");
                    break;
                    
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"AVAssetExportSessionStatusCompleted.");
                    finished = YES;
                    break;
                    
                case AVAssetExportSessionStatusUnknown:
                    NSLog(@"AVAssetExportSessionStatusUnknown");
                    break;
                    
                case AVAssetExportSessionStatusWaiting:
                    NSLog(@"AVAssetExportSessionStatusWaiting");
                    break;
                    
                case AVAssetExportSessionStatusExporting:
                    NSLog(@"AVAssetExportSessionStatusExporting");
                    break;
                    
            }
            
            if (completeCallback)
                completeCallback(mp4Path, finished);
        }];
        
    }
}


/**
 *  获取视频时长
 *  @return 单位秒
 */
+ (CGFloat)getVideoLength:(NSString *)videoPath {
    NSDictionary *opts = @{AVURLAssetPreferPreciseDurationAndTimingKey: @(YES)};
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:opts];
    if (!urlAsset)
        return 0;
    
    float audioDurationSeconds =CMTimeGetSeconds(urlAsset.duration);
    
    return audioDurationSeconds;
}


/**
 *  获取视频显示尺寸
 *  @param videoPath 视频文件文件路径
 *  @return 视频宽高
 */
+ (CGSize)getVideoSize:(NSString *)videoPath {
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    if (!urlAsset)
        return CGSizeZero;
    
    NSArray<AVAssetTrack *> *videoTracks = [urlAsset tracksWithMediaType:AVMediaTypeVideo];
    if (videoTracks == nil || videoTracks.count <= 0)
        return CGSizeZero;
    AVAssetTrack *videoTrack = videoTracks[0];
    CGAffineTransform t = videoTrack.preferredTransform;
    CGSize size = CGSizeApplyAffineTransform(videoTrack.naturalSize, t);
    if (size.width < 0) size.width *= -1;
    if (size.height < 0) size.height *= -1;
    
    return size;
}

/**
 * 获取视频缩略图
 * @param videoPath 视频文件文件路径
 */
+ (UIImage *)getVideoThumbnailImage:(NSString *)videoPath {
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumb;
}

+ (void)compressVideoForSend:(NSURL *)videoURL
               removeMOVFile:(BOOL)removeMOVFile
                saveFilePath:(NSString*)savePath
                  okCallback:(void (^)(NSString *mp4Path))okCallback
              cancelCallback:(void (^)())cancelCallback
                failCallback:(void (^)())failCallback {
//    MBProgressHUD *HUD = [LLUtils showActivityIndicatiorHUDWithTitle:@"准备中..."];
//    [LLUtils convertVideoFromMOVToMP4:videoURL complete:^(NSString *mp4Path, BOOL finished) {
//        if (removeMOVFile)
//            [LLUtils removeFileAtPath:videoURL.path];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [LLUtils hideHUD:HUD animated:YES];
//            
//            if (finished){
//                CGFloat fileSize = [LLUtils getFileSize:mp4Path];
//                NSString *fileSizeString = [LLUtils getFileSizeString:fileSize];
//                NSString *msg = [NSString stringWithFormat:@"视频压缩后文件大小为%@，确定要发送吗？",fileSizeString];
//                [LLUtils showConfirmAlertWithTitle:@"提示" message:msg yesTitle:@"发送" yesAction:^{
//                    if (okCallback)
//                        okCallback(mp4Path);
//                } cancelTitle:@"取消" cancelAction:^{
//                    if (cancelCallback)
//                        cancelCallback();
//                }];
//            }else {
//                [LLUtils showTextHUD:@"视频处理失败，已被删除或损坏"];
//                if (failCallback)
//                    failCallback();
//            }
//        });
//    }];
}

@end
