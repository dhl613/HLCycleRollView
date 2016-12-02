//
//  HLCycleRollPlusView.m
//  HLCycleRollView
//
//  Created by hct019 on 16/12/1.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import "HLCycleRollPlusView.h"

#define kScrollWidth   self.bounds.size.width
#define kScrollHeight  self.bounds.size.height

@interface HLCycleRollPlusView () <UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,assign) NSInteger imagesCounts;

@property (nonatomic,strong) NSTimer *timer;

@end

@implementation HLCycleRollPlusView

+ (instancetype)cycleRollPlusViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames {

    HLCycleRollPlusView *plus = [[HLCycleRollPlusView alloc] initWithFrame:frame imagesNames:imageNames];
    
    return plus;
}

- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames {
    if (self = [super init]) {
        self.frame = frame;
        _images = imageNames;
        _imagesCounts = _images.count;
        
        [self setupScrollView];
        [self setupImageViews];
        [self setupPageControl];
        [self addTimer];
    }
    return self;
}

- (void)setupScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled =  YES;
    _scrollView.bounces = NO;
    _scrollView.contentMode = UIViewContentModeScaleAspectFit;
    _scrollView.contentSize = CGSizeMake(kScrollWidth*(_imagesCounts + 2), 0);
    
    // 初始状态 显示中间图片
    [_scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
}
- (void)setupImageViews {
    
    for (int i = 0; i < _imagesCounts + 2 ; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kScrollWidth, 0, kScrollWidth, kScrollHeight)];
        [_scrollView addSubview:imageView];
        if (i == 0) {
            imageView.image = [UIImage imageNamed:_images[_imagesCounts - 1]]; // last image
            continue;
        }
        if (i == _imagesCounts +1) {
            imageView.image = [UIImage imageNamed:_images[0]];
            continue;
        }
        imageView.image = [UIImage imageNamed:_images[i-1]];
    }
}
/** 设置page */
- (void)setupPageControl {
    _pageControl = [[UIPageControl alloc] init];
    
    CGSize size = [_pageControl sizeForNumberOfPages:_imagesCounts+2];
    
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height-30);
    
    _pageControl.numberOfPages = _imagesCounts;
    
    [self addSubview:_pageControl];
    
    _pageControl.currentPage = 0;
}

/** API */
/** 设置pagecontrol的中心点 */
- (void)setPageControlOfCenter:(CGPoint)center {
    _pageControl.center = center;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset = scrollView.contentOffset;
    if (offset.x == 0) {
        [scrollView setContentOffset:CGPointMake(kScrollWidth*(_imagesCounts ), 0) animated:NO];
        return ;
    }
    if (offset.x == kScrollWidth*(_imagesCounts+1)) {
        [scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
        return ;
    }
    //_pageControl.currentPage = (NSInteger)offset.x/kScrollWidth -1;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    /** 设置current page*/
    
    CGPoint offset = scrollView.contentOffset;
    
    /** scrollview 滚动到位置0 */
    if (offset.x < kScrollWidth/2.0) {
        _pageControl.currentPage = _imagesCounts - 1;
        return ;
    }
    /** scrollView滚动到位置末 */
    if (offset.x > kScrollWidth*(_imagesCounts+0.5)) {
        _pageControl.currentPage = 0;
        return ;
    }
    /** 设置当前page */
    /** 向右滑动 */
    if (offset.x > kScrollWidth*(_pageControl.currentPage+1.5)) {
        
        _pageControl.currentPage = (NSInteger)offset.x/kScrollWidth;
        return ;
    }
    /** 向左滑动 */
    if ( offset.x < kScrollWidth*(_pageControl.currentPage+0.5) ) {
        _pageControl.currentPage = (NSInteger)offset.x/kScrollWidth -1;
        return ;
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addTimer];
}
#pragma mark - timer
- (void)addTimer {
    if (!_timer) {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    }
}
- (void)nextImage {
    
    [_scrollView setContentOffset:CGPointMake(kScrollWidth*(_pageControl.currentPage + 2), 0) animated:YES];
    if (_pageControl.currentPage == 4) {
        [self performSelector:@selector(delayChangeScrollView) withObject:nil afterDelay:1.0f];
        _pageControl.currentPage = 0;
    } else {
        _pageControl.currentPage += 1;
    }
}
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}
/** 给scrollView滚动动画时间*/
- (void)delayChangeScrollView {
    [_scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
