//
//  AutoScrollView.h
//  LoveMoments
//
//  Created by jens on 16/4/6.
//  Copyright © 2016年 张建帅. All rights reserved.
//

#import <UIKit/UIKit.h>

//第一步: 制定代理以及方法
@protocol AutoScrollViewDelegate <NSObject>

- (void)clickImageViewAtIndex:(NSInteger)index;

@end


@interface AutoScrollView : UIView
//第二步:设置代理属性
@property (nonatomic, assign) id <AutoScrollViewDelegate> delegate;

/** 自定义初始化方法 */
- (id)initWithFrame:(CGRect)frame
      imageUrlArray:(NSMutableArray *)imageArray
       timeInterval:(NSTimeInterval)time;



@end
