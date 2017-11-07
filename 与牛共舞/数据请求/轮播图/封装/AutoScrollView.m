//
//  AutoScrollView.m
//  LoveMoments
//
//  Created by jens on 16/4/6.
//  Copyright © 2016年 张建帅. All rights reserved.
//

#import "AutoScrollView.h"

@interface AutoScrollView () <UIScrollViewDelegate>

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *myScrollView;

/** 小圆点 */
@property (nonatomic, strong) UIPageControl *myPageControl;

/** 计时器 */
@property (nonatomic, strong) NSTimer *timer;

/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**  时间间隔 */
@property (nonatomic, assign) NSTimeInterval interval;


@end


@implementation AutoScrollView

- (id)initWithFrame:(CGRect)frame
      imageUrlArray:(NSMutableArray *)imageArray
       timeInterval:(NSTimeInterval)time {
    if (self = [super initWithFrame:frame]) {
        //给属性赋值,方便之后使用
        self.dataArray = imageArray;
        self.interval = time;
        NSMutableArray *tempArray = [NSMutableArray array];
        [tempArray addObject:[imageArray lastObject]];
        [tempArray addObjectsFromArray:imageArray];
        [tempArray addObject:[imageArray firstObject]];
 
        [self createScrollView:tempArray];
        
        [self initWithTimer];
    }
    return self;
}

#pragma mark ----开启计时器
- (void)initWithTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}
//计时器调用方法
- (void)timerAction {
    [self.myScrollView setContentOffset:CGPointMake(_myScrollView.contentOffset.x + _myScrollView.frame.size.width, 0) animated:YES];
}

//创建轮播图
- (void)createScrollView:(NSMutableArray *)imageArr {
    self.myScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    //内容量
    self.myScrollView.contentSize = CGSizeMake(self.bounds.size.width * imageArr.count, self.bounds.size.height);
    //整页滚动
    self.myScrollView.pagingEnabled = YES;
    //设置默认显示第一张图片
    _myScrollView.contentOffset = CGPointMake(_myScrollView.frame.size.width, 0);
    _myScrollView.delegate = self;
    
    [self addSubview:_myScrollView];
    
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(_myScrollView.frame.size.width * i, 0, _myScrollView.frame.size.width, _myScrollView.frame.size.height)];
//        [imageView setImageWithURL:[NSURL URLWithString:imageArr[i]]]

        //打开图片的交互
        imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [imageView addGestureRecognizer:tap];
        
        [_myScrollView addSubview:imageView];
        
    }
    
    self.myPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width - 100, self.bounds.size.height - 30, 100, 30)];
    _myPageControl.currentPage = 0;
    _myPageControl.numberOfPages = self.dataArray.count;
    [self addSubview:_myPageControl];
    
   
}

#pragma mark ---点击图片调用的操作
- (void)tapAction {
    if (_delegate && [_delegate respondsToSelector:@selector(clickImageViewAtIndex:)]) {
        [_delegate clickImageViewAtIndex:_myPageControl.currentPage];
    }
}


#pragma mark ----UIScrollViewDelegate
//滚动视图的偏移量发生变化,动态改变pagecontrol的当前页
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float pageNum =  scrollView.contentOffset.x / scrollView.frame.size.width;
    self.myPageControl.currentPage =  [[NSString stringWithFormat:@"%f", pageNum] integerValue] - 1;
}

//开始进行拖拽时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //滚动视图将计时器暂停,防止自动滚动与拖拽产生冲突
    [self.timer setFireDate:[NSDate distantFuture]];
    
}

//结束滚动动画
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self changeHeaderAndFooterImage];
}


//已经结束减速, 从新开启计时器
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    //判断是否为第一张图 或者 最后一张图
    [self changeHeaderAndFooterImage];
    
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.interval]];
}

//对最后一张图片 和 第一张图片进行处理
- (void)changeHeaderAndFooterImage {
    //第一张图
    if (_myScrollView.contentOffset.x == 0) {
        [_myScrollView setContentOffset:CGPointMake(self.dataArray.count * _myScrollView.frame.size.width, 0) animated:NO];
    }
    //最后一张图片
    if (_myScrollView.contentOffset.x == (self.dataArray.count + 1) * _myScrollView.frame.size.width) {
        [_myScrollView setContentOffset:CGPointMake(_myScrollView.frame.size.width, 0) animated:NO];
        
    }
  
}











/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
