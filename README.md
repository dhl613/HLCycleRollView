# HLCycleRollView
`HLCycleRollView`是一个图片循环轮播器，使用简单，快捷。<br><br>
# Demo
![](https://github.com/dhl613/HLCycleRollView/blob/master/HLCycleRollView/scrollRoll.gif) <br>
# Basic Usage
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

# Suggestion
循环轮播器有两个，但是HLCycleRollView不够丝滑，后期也没有加定时器，点击事件，使用起来很不方便<br><br>

重点推荐 `HLCycleRollPlusView`，循环轮播器的plus版，非常丝滑，拿来直接使用。<br><br>

# License
HLCycleRollView is licensed under the MIT license.[(http://opensource.org/licenses/MIT)](http://opensource.org/licenses/MIT)<br>
