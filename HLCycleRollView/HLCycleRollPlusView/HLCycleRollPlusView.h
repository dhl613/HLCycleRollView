//
//  HLCycleRollPlusView.h
//  HLCycleRollView
//
//  Created by hct019 on 16/12/1.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HLCycleRollPlusImagesClickedBlock)(NSInteger column);

@interface HLCycleRollPlusView : UIView

+ (instancetype)cycleRollPlusViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames;

- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames;

- (void)setPageControlOfCenter:(CGPoint)center;

/** 图片行号从1开始*/
- (void)imagesDidClicked:(HLCycleRollPlusImagesClickedBlock)imageClick;

@end
