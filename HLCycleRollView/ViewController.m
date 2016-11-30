//
//  ViewController.m
//  HLCycleRollView
//
//  Created by hct019 on 16/11/30.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import "ViewController.h"
#import "HLCycleRollView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *images = @[@"image0",@"image1",@"image2",@"image3",@"image4"];
    
    HLCycleRollView *cycleView = [HLCycleRollView cycleRollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) imageNames:images];
    
    [self.view addSubview:cycleView];
    
    cycleView.center = self.view.center;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
