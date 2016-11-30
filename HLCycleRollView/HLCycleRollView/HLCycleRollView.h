//
//  HLCycleRollView.h
//  HLBroswerImageCycleDemo
//
//  Created by hct019 on 16/11/30.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCycleRollView : UIView

+ (instancetype)cycleRollViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames;

- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames;

@end
