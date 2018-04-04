//
//  HLGroupImageTool.m
//  GroupAvatarDemo
//
//  Created by huayuni on 2018/3/2.
//  Copyright © 2018年 Kate. All rights reserved.
//

#import "HLGroupImageTool.h"
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonDigest.h>
#import "NSString+MD5.h"

@implementation HLGroupImageTool
{
    // 私有实例变量 无setter，getter方法 只能通过_session/self->session访问
    NSURLSession *_session;

}
- (instancetype)init {
    self =  [super init];
    if (self) {
        _session = [NSURLSession sharedSession];
        static dispatch_once_t onceToken;
        /// 创建缓存目录 所有使用本类下载的图片均存放于此
        dispatch_once(&onceToken, ^{
            NSFileManager *manager = NSFileManager.defaultManager;
            NSString *imagepath = [self cachedPath];
            if (![manager fileExistsAtPath:imagepath]) {
                [manager createDirectoryAtPath:imagepath withIntermediateDirectories:YES attributes:nil error:NULL];
            }
        });
    }
    return self;
}
- (void)downloadImagesWithURLs:(NSArray<NSString *> *)urls completeHandler:(void(^)(NSDictionary *imageDic))handler {
//    NSMutableArray *images = [NSMutableArray array];
    NSMutableDictionary *imagesDic = [NSMutableDictionary dictionary];
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    for (NSInteger i = 0; i <urls.count; i++) {
        NSString *url = urls[i];
        
        BOOL isDownload = [self isCachedInDiskWith:url];
        if (isDownload) {
            /// 已经下载
            
            NSString *imagepath = [self cachedFileDirectoryWithKey:url];
            NSData *imagedata = [NSData dataWithContentsOfFile:imagepath];
            UIImage *image = [UIImage imageWithData:imagedata];
            [imagesDic setObject:image forKey:@(i)];
//            [images addObject:[UIImage imageWithData:imagedata]];
            if (imagesDic.allValues.count == urls.count) {
                !handler ?: handler(imagesDic);
                return;
            }
            
        } else {
            /// 未下载
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                [self downloadImageWithURL:[NSURL URLWithString:url] completeHandler:^(UIImage *image, NSError *error) {
                    if (!error) {
//                        [images addObject:image];
                        [imagesDic setObject:image forKey:@(i)];
                        //                        NSLog(@"%@",images);
                    }
                    dispatch_group_leave(group);
                }];
            });
        }
    }
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            /// 主线程回调
            !handler ?: handler(imagesDic);
        });
    });
    
}
- (void)downloadImageWithURL:(NSURL *)imageurl completeHandler:(completeHandler)handler {
    
    NSURLSessionDownloadTask *downloadTask = [_session downloadTaskWithURL:imageurl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *imageData = [NSData dataWithContentsOfURL:location];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        // 下载完成
        dispatch_async(dispatch_get_main_queue(), ^{
            !handler ?: handler(image,error);
        });
        NSFileManager *manager = NSFileManager.defaultManager;
        NSString *imageKey = [self cachedFileDirectoryWithKey:imageurl.absoluteString];
        [manager createFileAtPath:imageKey contents:imageData attributes:nil];
    }];
    
    [downloadTask resume];
}
- (NSString *)cachedFileDirectoryWithKey:(NSString *)key {
    return [NSString stringWithFormat:@"%@/%@",[self cachedPath],[self cachedFileNameForKey:key]];
}
- (NSString *)cachedPath {
    NSString *cachepath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    return [NSString stringWithFormat:@"%@/com.apple.groupImages",cachepath];
}
- (NSString *)cachedFileNameForKey:(NSString *)key {

    NSString *result = [key md5];
    
    NSString *filename = [result stringByAppendingFormat:@".%@",[key pathExtension]];
    
    return filename;
}

- (BOOL)isCachedInDiskWith:(NSString *)key {
    NSString *imagePath = [self cachedFileDirectoryWithKey:key];
    NSFileManager *filemanager = [NSFileManager defaultManager];
    return [filemanager fileExistsAtPath:imagePath];
}

- (NSString *)md5WithString:(NSString *)str {
    const char *string = [str UTF8String];
    if (string == NULL) {
        string = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, (CC_LONG)strlen(string), r);

    NSString *result = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",r[0],r[1],r[2],r[3],r[4],r[5],r[6],r[7],r[8],r[9],r[10],r[11],r[12],r[13],r[14],r[15]];
    return result;
}

@end
