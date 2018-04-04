//
//  HLGroupImageTool.h
//  GroupAvatarDemo
//
//  Created by huayuni on 2018/3/2.
//  Copyright © 2018年 Kate. All rights reserved.
//

/// 图片下载工具

#import <Foundation/Foundation.h>

@class UIImage;

@interface HLGroupImageTool : NSObject

typedef void(^completeHandler)(UIImage *image, NSError *error);

/// 批量图片下载(按图片数组顺序放置imageDic key为number integer)
- (void)downloadImagesWithURLs:(NSArray<NSString *> *)urls completeHandler:(void(^)(NSDictionary *imageDic))handler;

@end

