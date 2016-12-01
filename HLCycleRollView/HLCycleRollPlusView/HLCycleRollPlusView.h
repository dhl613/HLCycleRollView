//
//  HLCycleRollPlusView.h
//  HLCycleRollView
//
//  Created by hct019 on 16/12/1.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCycleRollPlusView : UIView

+ (instancetype)cycleRollPlusViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames;

- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames;

- (void)setPageControlOfCenter:(CGPoint)center;

@end