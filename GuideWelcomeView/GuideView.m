//
//  GuideView.m
//  GuideWelcomeView
//
//  Created by yxhe on 16/10/11.
//  Copyright © 2016年 tashaxing. All rights reserved.
//

// ---- 第一次启动或者更新版本后的引导页 ---- //

#import "GuideView.h"

@interface GuideView ()<UIScrollViewDelegate>
{
    UIScrollView *_pageScrollView;
    UIPageControl *_pageControl;
}

@end

@implementation GuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self createView];
    }
    return self;
}

- (void)createView
{
    // scrollview
    _pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _pageScrollView.contentSize = CGSizeMake(self.frame.size.width * 4, self.frame.size.height);
    _pageScrollView.backgroundColor = [UIColor clearColor]; // 背景透明
    _pageScrollView.showsHorizontalScrollIndicator = NO;
    _pageScrollView.pagingEnabled = YES;
    _pageScrollView.bounces = NO;
    _pageScrollView.delegate = self;
    
    // 添加图片
    for (int i = 0; i < 3; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width * i, 0, self.frame.size.width, self.frame.size.height)];
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d.jpg", i + 1]];
        imageView.image = image;
        
        // 最后一页添加进入主界面的按钮
        if (i == 2)
        {
            UIButton *enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            enterBtn.frame = CGRectMake(self.frame.size.width / 2 - 70, 500, 140, 30);
            enterBtn.backgroundColor = [UIColor blueColor];
            [enterBtn setTitle:@"enter" forState:UIControlStateNormal];
            [enterBtn addTarget:self action:@selector(enterMainView) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:enterBtn];
            imageView.userInteractionEnabled = YES; // 一定要打开这一项
        }
        [_pageScrollView addSubview:imageView];
    }
    [self addSubview:_pageScrollView];
    
    // pagecontrol
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 50, self.frame.size.width, 50)];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor yellowColor];
    _pageControl.backgroundColor = [UIColor clearColor];
    _pageControl.numberOfPages = 3;
    _pageControl.currentPage = 0;
    [self addSubview:_pageControl];
}

- (void)enterMainView
{
    // 进入主界面
    [UIView animateWithDuration:1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    NSLog(@"enter the main view");
}

#pragma mark - scrollview 代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger curIndex = scrollView.contentOffset.x / scrollView.frame.size.width;
    _pageControl.currentPage = curIndex;
    
    // 当滑出主界面时进入
    if (curIndex == 3)
    {
        [self enterMainView];
    }
}



@end
