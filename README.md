# HLCycleRollView
`HLCycleRollView` 是一个图片循环轮播器，使用简单，快捷。<br><br>
# Demo
![效果预览](https://github.com/dhl613/HLCycleRollView/blob/master/HLCycleRollView/scrollRoll.gif) <br>
# Basic Usage
``` Objective-C
    NSArray *images = @[@"image0",@"image1",@"image2",@"image3",@"image4"];
    
    HLCycleRollView *cycleView = [HLCycleRollView cycleRollViewWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100) imageNames:images];
    
    [self.view addSubview:cycleView];
    
    cycleView.center = self.view.center;
    
    NSArray *imageurls = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522842640750&di=cd734504bdd6d0409b9819c235b496e7&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2F48540923dd54564ea36abf58b7de9c82d1584f47.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522842745164&di=0de522368990a5a319f91644cd5ecb0e&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201507%2F31%2F20150731120123_vkSYi.thumb.700_0.jpeg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1522842825502&di=cd2556be379c26e093bc7dfa0a8f4383&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fb21c8701a18b87d6b299e259030828381e30fd99.jpg"];
    
//    HLCycleRollPlusView *plus = [HLCycleRollPlusView cycleRollPlusViewWithFrame:CGRectMake(0, 0, 200, 100) imageNames:images];
    HLCycleRollPlusView *plus = [[HLCycleRollPlusView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 300) urls:imageurls];
    
    [self.view addSubview:plus];
    
    plus.center = CGPointMake(self.view.center.x, 150);
    [plus setPageControlOfCenter:CGPointMake(plus.frame.size.width -50, plus.frame.size.height - 20)];
    
    [plus imagesDidClicked:^(NSInteger column) {
        NSLog(@"%ld",column);
    }];
```

# Suggestion
循环轮播器HLCycleRollView流畅，简单，易用。<br><br>

由于技术水平有限，尚有不足之处，往后会继续改进，也希望能得到前辈的指点，如果可以O(∩_∩)O哈哈~ ^o^。
# License
HLCycleRollView is licensed under the MIT license.[(http://opensource.org/licenses/MIT)](http://opensource.org/licenses/MIT)<br>
