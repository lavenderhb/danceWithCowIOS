//
//  DMScrolSegmentView.m
//  DM
//
//  Created by dm on 16/8/26.
//  Copyright © 2016年 dm. All rights reserved.
//

#import "TTScrolSegmentView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 

@interface TTScrolSegmentView () <UIScrollViewDelegate>
/* 文字scrollView */
@property (nonatomic, strong) UIScrollView *titleScrollView;
/* 控制器 */
@property (nonatomic, strong) UIScrollView *contentScrollView;
/* 标签按钮 */
@property (nonatomic, strong) NSMutableArray *buttons;
/* 选中的按钮 */
@property (nonatomic, strong) UIButton *selectedBtn;
/* 选中的按钮背景图 */
@property (nonatomic, strong) UIView *backView;


@property (nonatomic, strong) NSArray<UITableViewController *> *controllers;
@property (nonatomic, strong) NSArray<NSString *> *titles;


@end

@implementation TTScrolSegmentView

static CGFloat const titleH = 35;/** 文字高度  */

static CGFloat const MaxScale = 1.0;/** 选中文字放大  */


- (void)viewDidLoad{
    
    
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        self.buttons = [NSMutableArray array];
    }
    return _buttons;
}

// 调用的重要的方法  gray
- (instancetype)initWithControllers:(NSArray<UITableViewController *> *)controllers titles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.controllers = controllers;
        self.titles = titles;
//        if (controllers == nil || titles == nil) {
//            printf("00");
//        }
    }
    return self;
}



- (void)show {
    if (self.controllers.count != 0 && self.titles.count != 0) {
        if (self.controllers.count >= self.titles.count) {
            for (int i = 0; i < self.titles.count; i++) {
                [self addChildViewController:self.controllers[i] title:self.titles[i]];
            }
        } else {
            for (int i = 0; i < self.controllers.count; i++) {
                [self addChildViewController:self.controllers[i] title:self.titles[i]];
            }
        }
        
    } else {
        NSLog(@"Error: Controllers or Titles is Empty!!!");
        return;
    }
    
    [self setTitleScrollView]; /* 添加文字标签 */
    [self setContentScrollView]; /* 添加scrollView */
    [self setupTitle]; /* 设置标签按钮 文字 背景图*/
    UITableViewController *superVC = [self findViweController:self];
    self.contentScrollView.contentSize = CGSizeMake(superVC.childViewControllers.count * kScreenWidth, 0);
    // 整屏翻页 
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    self.contentScrollView.delegate = self;
    // 反弹效果
    self.contentScrollView.bounces = NO;
    
    ///  contentOffset
    CGPoint pt = CGPointMake(0, 0);
    [_contentScrollView setContentOffset:pt];        //设置scrollview 的偏移量
    [self scrollViewDidScroll:_contentScrollView];   //模拟scrollview 被滑动

    
}


/**
 *  找到自己的视图控制器
 */
- (UITableViewController *)findViweController:(UIView *)sourceView {
    id target = sourceView;
    while (target) {
        // 自己肯定不是, 直接跳过自己查找, 提高代码执行的效率
        // 通过UIResponder的属性, 查找上一级
        target = ((UIResponder *)target).nextResponder;
        // 对比类
        if ([target isKindOfClass:[UIViewController class]]) {
            // 找到后直接跳出循环, 提高代码的执行效率 (可以先执行一次, 记录这个控制器, 之后就不用一直调用此方法了)
            break;
        }
    }
    return target;
    
}


/**
 *  给自己所在的视图控制器添加子视图控制器, 并利用title属性记录标签名
 */
- (void)addChildViewController:(UITableViewController *)childVC title:(NSString *)vcTitle {
    UITableViewController *superVC = [self findViweController:self];
    childVC.title = vcTitle;
    [superVC addChildViewController:childVC];
}

/**
 *  设置文字标签ScrollView
 */
- (void)setTitleScrollView {
    UITableViewController *superVC = [self findViweController:self];

    CGRect rect = CGRectMake(0, 0, kScreenWidth, titleH);
    // 此时只设置frame
    self.titleScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.titleScrollView.opaque = NO;
    self.titleScrollView.backgroundColor = [UIColor clearColor];
    // 添加到父视图上, 这个父视图是父视图控制器的根视图
    [superVC.view addSubview:self.titleScrollView];
}

/**
 *  设置子视图控制器所在的ScrollView
 */
- (void)setContentScrollView {
    UITableViewController *superVC = [self findViweController:self];
    CGFloat y = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect = CGRectMake(0, y, kScreenWidth, kScreenHeight - titleH);
    // 此时只设置frame,
    self.contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    self.contentScrollView.backgroundColor = [UIColor clearColor];
    // 添加到父视图, 这个父视图也是父视图控制器的根视图
    [superVC.view addSubview:self.contentScrollView];
}

/**
 *  设置标签
 */
- (void)setupTitle {
    UIViewController *superVC = [self findViweController:self];
    // 标签的个数, 根据父视图控制器的子视图控制器个数获得
    NSUInteger count = superVC.childViewControllers.count;
    // 图片在x轴上的初始位置
    CGFloat x = 0;
    // 标签的宽
    CGFloat w = kScreenWidth / 4;
    // 标签的高
    CGFloat h  = titleH;
    // 添加图片
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(x, h - 3, w, 3)];
    self.backView.backgroundColor = [UIColor orangeColor];
    
    // 这个地方可以设置是否有下滑的那一条横线
    [self.titleScrollView addSubview:self.backView];
    
    // 创建标签button
    for (int i = 0; i < count; i++) {
        // 找到对应的controller
        UIViewController *vc = superVC.childViewControllers[i];
        // 设置每个标签的x
        x = i * w;
        // 设置每个标签的frame
        CGRect rect = CGRectMake(x, 0, w, h);
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        btn.frame = rect;
        // 利用button的tag属性做下记录(记录button对应的Controller在childControllers的下标)
        btn.tag = i;
        // 设置标签的文字
        [btn setTitle:vc.title forState:(UIControlStateNormal)];
        [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.backgroundColor = [UIColor clearColor];
        // 添加标签点击事件
        [btn addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
        // 把标签添加到标签数组中
        [self.buttons addObject:btn];
        // 展示在标签ScrollView上
        [self.titleScrollView addSubview:btn];
        if (i == 0) {
            // 开始的时候默认选中第一个button
            [self click:btn];
            
        }
    }
    // 设置标签ScrollView的内容页大小
    self.titleScrollView.contentSize = CGSizeMake(count * w, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
}

/**
 *  标签点击事件
 */


- (void)click:(UIButton *)sender {
    // 设置为选中的标签
    [self selectTitleBtn:sender];
    NSInteger i = sender.tag;
    CGFloat x = i * kScreenWidth;
    // 设置子视图控制器ScrollView的偏移量  segment
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
//    self.titleScrollView.contentOffset = CGPointMake(0, 0);

    if (i == 0){
        self.titleScrollView.contentOffset = CGPointMake(0, 0);

    }else if(i == 4){
        self.titleScrollView.contentOffset = CGPointMake(kScreenWidth/4, 0);

    }else{
        self.titleScrollView.contentOffset = CGPointMake(0, 0);

    }
//    if (i == 0){
//        self.contentScrollView.contentOffset = CGPointMake(0, 0);
//    }else if(i == 1){
//        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth / 16, 0);
//    }else if(i == 2){
//        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth / 8, 0);
//    }else if(i == 3){
//        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth / 16 * 3, 0);
//    }else if(i == 4){
//        self.contentScrollView.contentOffset = CGPointMake(kScreenWidth / 4, 0);
//    }


    // 设置该内容页内容展示
    [self setUpOneChildControllder:i];
}



/**
 *  把点击的button设置为选中的button
 */
- (void)selectTitleBtn:(UIButton *)btn {
    [self.selectedBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    //    self.selectedBtn.transform = CGAffineTransformIdentity;
    // 设置选中的button的颜色
    [btn setTitleColor:[UIColor orangeColor] forState:(UIControlStateNormal)];
    btn.transform = CGAffineTransformMakeScale(MaxScale, MaxScale);
    self.selectedBtn = btn;
    // 把选中的button移动到屏幕的中央
//    [self setupTitleCenter:btn];
}

/**
 *  把选中的button移动到屏幕的中央
 */
- (void)setupTitleCenter:(UIButton *)sender {
    // 找到选中的button距离屏幕的中心有多远
    CGFloat offset = sender.center.x - kScreenWidth * 0.5;
    // 如果在屏幕中心的左边
    if (offset < 0) {
        // 不做偏移
        offset = 0;
    }
    // 标签ScrollView的偏移量打到最右时
    CGFloat maxOffset = self.titleScrollView.contentSize.width - kScreenWidth;
    // 如果这个偏移量大于最大
    if (offset > maxOffset && maxOffset >0) {
        // 设置为最大
        offset = maxOffset;
    }
    // 偏移
//    [self.titleScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
//    [self.contentScrollView setContentOffset:CGPointMake(2 * offset, 0) animated:YES];
}

/**
 *  把子视图控制器上的内容展示出来
 */
- (void)setUpOneChildControllder:(NSInteger)index {
    UITableViewController *superVC = [self findViweController:self];
    CGFloat x = index * kScreenWidth;
    UITableViewController *vc = superVC.childViewControllers[index];
    if (vc.view.superview) {
        // 如果已经展示过, 直接返回
        return;
    }
    vc.view.frame = CGRectMake(x, 0, kScreenWidth, kScreenHeight - self.contentScrollView.frame.origin.y - 44);
    [self.contentScrollView addSubview:vc.view];
}

#pragma mark --- UIScrollViewDelegate
/**
 *  scrollView滑动结束时触发
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger i = self.contentScrollView.contentOffset.x / kScreenWidth;
    // 设置选中的button
    [self selectTitleBtn:self.buttons[i]];
    // 设置展示的页面
    [self setUpOneChildControllder:i];
}
/**
 *  scrollView交互, 就会触发  viewdidload
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 此时的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 左边标签的下标
    NSInteger leftIndex = offsetX / kScreenWidth;
    // 右边标签的下标
    NSInteger rightIndex = leftIndex + 1;
    
    // 左边的标签
    UIButton *leftButton = self.buttons[leftIndex];
    // 右边的标签
    UIButton *rightButton = nil;
    if (rightIndex < self.buttons.count) {
        // 如果右边的标签的下标大于等于标签的总数, 不赋值
        rightButton = self.buttons[rightIndex];
    }
    // 右边按钮变大的比例
    CGFloat scaleR = offsetX / kScreenWidth - leftIndex;
    // 左边按钮变大的比例
    CGFloat scaleL = 1 - scaleR;
    // 变大系数
    CGFloat transScale = MaxScale - 1;
    // 设置图片的偏移量
    // (offsetX * (self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width) 按照比例偏移
    self.backView.transform = CGAffineTransformMakeTranslation((offsetX * (self.titleScrollView.contentSize.width / self.contentScrollView.contentSize.width)), 0);
    // 设置左边按钮变大
    leftButton.transform = CGAffineTransformMakeScale(scaleL * transScale + 1, scaleL *transScale + 1);
    // 设置右边按钮变大
    rightButton.transform = CGAffineTransformMakeScale(scaleR *transScale + 1, scaleR * transScale + 1);
    
    // 设置颜色渐变
    //    UIColor *rightColor = Color(174 + 66 * scaleR, 174 - 71 * scaleR, 174 - 174 * scaleR);
    //    UIColor *leftColor = Color(174 + 66 * scaleL, 174 - 71 * scaleL, 174 - 174 * scaleL);
    //    [leftButton setTitleColor:leftColor forState:(UIControlStateNormal)];
    //    [rightButton setTitleColor:rightColor forState:(UIControlStateNormal)];
}


- (void)jumpCoumMentVC6:(NSInteger)index
{
    [self click:self.buttons[index]];
}

@end
