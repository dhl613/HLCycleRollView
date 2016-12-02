//
//  HLCycleRollView.m
//  HLBroswerImageCycleDemo
//
//  Created by hct019 on 16/11/30.
//  Copyright © 2016年 dhl. All rights reserved.
//

#import "HLCycleRollView.h"

#define kScrollWidth  self.bounds.size.width
#define kScrollHeight self.bounds.size.height

@interface HLCycleRollView () <UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *leftIV;
@property (nonatomic,strong) UIImageView *centerIV;
@property (nonatomic,strong) UIImageView *rightIV;
@property (nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,assign) NSInteger currentImageIndex;
@property (nonatomic,assign) NSInteger imagesCounts;

@end

@implementation HLCycleRollView

+ (instancetype)cycleRollViewWithFrame:(CGRect)frame imageNames:(NSArray<NSString *> *)imageNames {
    HLCycleRollView *view = [[HLCycleRollView alloc] initWithFrame:frame imagesNames:imageNames];
    return view;
}
- (instancetype)initWithFrame:(CGRect)frame imagesNames:(NSArray<NSString *> *)imageNames {
    if (self = [super init]) {
        self.frame = frame;
        _images = imageNames;
        _imagesCounts = _images.count;
        
        [self setupScrollView];
        [self setupImageViews];
        [self setDefaultsImages];
        [self setupPageControl];
    }
    return self;
}
/** 设置scrollView */
- (void)setupScrollView {
    /** 设置3个ImageView 始终显示中间的ImageView */
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled =  YES;
    _scrollView.contentMode = UIViewContentModeScaleAspectFit;
    _scrollView.contentSize = CGSizeMake(kScrollWidth*3, 0);
    
    // 初始状态 显示中间图片
    [_scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
}
/** 添加imageView */
- (void)setupImageViews {
    _leftIV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScrollWidth, kScrollHeight)];
    [_scrollView addSubview:_leftIV];
    
    _centerIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScrollWidth, 0, kScrollWidth, kScrollHeight)];
    [self.scrollView addSubview:_centerIV];
    
    _rightIV = [[UIImageView alloc] initWithFrame:CGRectMake(kScrollWidth*2, 0, kScrollWidth, kScrollHeight)];
    [self.scrollView addSubview:_rightIV];
    
}
/** 设置默认显示图片*/
- (void)setDefaultsImages {
    
    _centerIV.image = [UIImage imageNamed:_images[0]];
    
    _leftIV.image = [UIImage imageNamed:_images[_imagesCounts-1]];
    
    _rightIV.image = [UIImage imageNamed:_images[1]];
    
    _currentImageIndex = 0;
    
    _pageControl.currentPage = _currentImageIndex;
}
/** 设置page */
- (void)setupPageControl {
    _pageControl = [[UIPageControl alloc] init];
    
    CGSize size = [_pageControl sizeForNumberOfPages:_imagesCounts];
    
    _pageControl.bounds = CGRectMake(0, 0, size.width, size.height);
    
    _pageControl.center = CGPointMake(self.center.x, self.bounds.size.height-30);
    
    _pageControl.numberOfPages = _imagesCounts;
    
    [self addSubview:_pageControl];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self reloadImage];
    
    _pageControl.currentPage = _currentImageIndex;
    
    [_scrollView setContentOffset:CGPointMake(kScrollWidth, 0) animated:NO];
    
}

- (void)reloadImage {
    
    CGPoint offset  = _scrollView.contentOffset;
    if (offset.x > kScrollWidth) { // 向右滑动了后
        
        if (_currentImageIndex == _imagesCounts-1) {
            _currentImageIndex = 0;
            _rightIV.image = [UIImage imageNamed:_images[_currentImageIndex+1]];
            _leftIV.image = [UIImage imageNamed:_images[_imagesCounts-1]];
            
        } else {
            
            _currentImageIndex += 1;
            if (_currentImageIndex == _imagesCounts -1) {
                _leftIV.image = [UIImage imageNamed:_images[_currentImageIndex -1]];
                _rightIV.image = [UIImage imageNamed:_images[0]];
            } else {
                _leftIV.image = [UIImage imageNamed:_images[_currentImageIndex - 1]];
                _rightIV.image = [UIImage imageNamed:_images[_currentImageIndex + 1]];
            }
            
        }
        // 中间图片 当前显示图片
        _centerIV.image = [UIImage imageNamed:_images[_currentImageIndex]];
        
        
    } else if(offset.x < kScrollWidth ) { // 向左滑动了后
        
        if (_currentImageIndex == 0) {
            _currentImageIndex = _imagesCounts -1;
            _leftIV.image = [UIImage imageNamed:_images[_currentImageIndex -1]];
            _rightIV.image = [UIImage imageNamed:_images[0]];
            
        } else {
            
            _currentImageIndex -= 1;
            if (_currentImageIndex == 0) {
                _leftIV.image = [UIImage imageNamed:_images[_imagesCounts -1]];
                _rightIV.image = [UIImage imageNamed:_images[_currentImageIndex +1]];
            } else {
                _leftIV.image = [UIImage imageNamed:_images[_currentImageIndex -1]];
                _rightIV.image = [UIImage imageNamed:_images[_currentImageIndex +1]];
            }
            
        }
        // 中间图片 当前显示图片
        _centerIV.image = [UIImage imageNamed:_images[_currentImageIndex]];
        
    }
}
/*
 Only override drawRect: if you perform custom drawing.
 An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
