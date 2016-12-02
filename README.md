# HLCycleRollView<br>
`HLCycleRollView`是一个图片循环轮播器，使用简单，快捷。<br><br>

# Basic Usage<br>
``` Objective-C
NSArray *images = @[@"image0",@"image1",@"image2",@"image3",@"image4"];
    
    HLCycleRollView *cycleView = [HLCycleRollView cycleRollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) imageNames:images];
    
    [self.view addSubview:cycleView];
    
    cycleView.center = self.view.center;
    
    HLCycleRollPlusView *plus = [HLCycleRollPlusView cycleRollPlusViewWithFrame:CGRectMake(0, 0, 200, 100) imageNames:images];
    
    [self.view addSubview:plus];
    
    plus.center = CGPointMake(self.view.center.x, 150);
    [plus setPageControlOfCenter:CGPointMake(plus.frame.origin.x -30, plus.frame.origin.y - 20)];
    
    [plus imagesDidClicked:^(NSInteger column) {
        NSLog(@"%ld",column);
    }];
```

# License<br>
HLCycleRollView is licensed under the MIT license.[(http://opensource.org/licenses/MIT)](http://opensource.org/licenses/MIT)<br>
