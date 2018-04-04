//
//  HLCycleRollPlusView.h
//  HLCycleRollView
//
//  Created by dhl613 on 16/12/1.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HLCycleRollPlusImagesClickedBlock)(NSInteger column);

@interface HLCycleRollPlusView : UIView

/*
 * 网络图片
 */
- (instancetype)initWithFrame:(CGRect)frame urls:(NSArray<NSString *> *)urls;


/**
 * 本地图片
 */
+ (instancetype)cycleRollPlusViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames;
- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames;

- (void)setPageControlOfCenter:(CGPoint)center;

/** 图片序号从0开始*/
- (void)imagesDidClicked:(HLCycleRollPlusImagesClickedBlock)imageClick;

@end
