//
//  PDAutoScrollView.m
//  PDAutoSlideScrollView
//
//  Created by Jack on 16/6/9.
//  Copyright © 2016年 jpanda. All rights reserved.
//

#import "PDAutoSlideScrollView.h"

@interface PDAutoSlideScrollView ()<UIScrollViewDelegate>
{
    NSInteger _prevousIndex;
    NSMutableArray *_imageviews;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
    NSTimer *_timer;
    CGSize _frameSize;
}
@end

@implementation PDAutoSlideScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameSize = frame.size;
        [self initVariable];
        [self initLayout];
    }
    return self;
}


- (void)initVariable
{
    _imageviews = [NSMutableArray new];
    _prevousIndex = 0;
}

- (void)setDataSource:(NSArray<UIImage *> *)dataSource
{
    _dataSource = dataSource;
    _pageControl.numberOfPages = _dataSource.count;
    _pageControl.currentPage = 0;
    _pageControl.hidden = NO;
    _scrollView.scrollEnabled = YES;
    if (_timer) [self stopTimer];
    UIImageView *leftImageview = _imageviews[0];
    UIImageView *centerImageview = _imageviews[1];
    UIImageView *rightImageview = _imageviews[2];
    if (_dataSource.count > 2) {
        leftImageview.image = _dataSource[0];
        centerImageview.image = _dataSource[1];
        rightImageview.image = _dataSource[2];
        [self startTimer];
    } else if (_dataSource.count == 2) {
        leftImageview.image = _dataSource[0];
        centerImageview.image = _dataSource[1];
        rightImageview.image = _dataSource[0];
        [self startTimer];
    } else if (_dataSource.count == 1) {
        leftImageview.image = _dataSource[0];
        _pageControl.hidden = YES;
        _scrollView.scrollEnabled = NO;
    }
}

- (void)initLayout
{
    NSInteger pageCount = 3;
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _frameSize.width, _frameSize.height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(_frameSize.width * pageCount, _frameSize.height);
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    for (int i = 0; i < pageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*_frameSize.width, 0, _frameSize.width, _frameSize.height)];
        [_imageviews addObject:imageView];
        [_scrollView addSubview:imageView];
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _frameSize.height - 25, _frameSize.width, 25)];
    [self addSubview:_pageControl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tapGestureRecognizer
{
    if (_selectionHandle) {
        _selectionHandle(_pageControl.currentPage);
    }
}

- (void)displayNext
{
    _prevousIndex = _scrollView.contentOffset.x/_frameSize.width;
    if (_prevousIndex == 2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:CGPointMake((_prevousIndex+1) * _frameSize.width, 0) animated:YES];
    }
}

- (void)startTimer
{
    _timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(displayNext) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    _prevousIndex = _scrollView.contentOffset.x/_frameSize.width;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reset];
    [self startTimer];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reset];
}

#pragma mark -

- (void)reset
{
    NSInteger theIndex = _scrollView.contentOffset.x/_frameSize.width;
    if (theIndex > _prevousIndex) {
        if (_pageControl.currentPage == _dataSource.count-1) {
            _pageControl.currentPage = 0;
        } else {
            _pageControl.currentPage = _pageControl.currentPage + 1;
        }
    } else if (theIndex < _prevousIndex) {
        if (_pageControl.currentPage == 0) {
            _pageControl.currentPage = _dataSource.count-1;
        } else {
            _pageControl.currentPage = _pageControl.currentPage - 1;
        }
    }
    
    UIImageView *leftImageview;
    UIImageView *centerImageview;
    UIImageView *rightImageview;
    
    if (_pageControl.currentPage == 0) {
        leftImageview = _imageviews[0];
        leftImageview.image = _dataSource[_dataSource.count - 1];
        centerImageview = _imageviews[1];
        centerImageview.image = _dataSource[_pageControl.currentPage];
        rightImageview = _imageviews[2];
        rightImageview.image = _dataSource[_pageControl.currentPage +1];
    } else if (_pageControl.currentPage == _dataSource.count - 1) {
        leftImageview = _imageviews[0];
        leftImageview.image = _dataSource[_pageControl.currentPage - 1];
        centerImageview = _imageviews[1];
        centerImageview.image = _dataSource[_pageControl.currentPage];
        rightImageview = _imageviews[2];
        rightImageview.image = _dataSource[0];
    } else {
        leftImageview = _imageviews[0];
        leftImageview.image = _dataSource[_pageControl.currentPage -1];
        centerImageview = _imageviews[1];
        centerImageview.image = _dataSource[_pageControl.currentPage];
        rightImageview = _imageviews[2];
        rightImageview.image = _dataSource[_pageControl.currentPage +1];
    }
    [_scrollView scrollRectToVisible:CGRectMake(_frameSize.width, 0, _frameSize.width, _frameSize.height) animated:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
