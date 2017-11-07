//
//  GKScrolSegmentView.h
//  与牛共舞
//
//  Created by dm on 17/3/30.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKScrolSegmentView : UIView


- (void)show;

- (instancetype)initWithControllers:(NSArray<UITableViewController *> *)controllers titles:(NSArray<NSString *> *)titles;
//-- 这个点击事件去判断全局偏移量的设定，然后根据位置进行设定
- (void)jumpCoumMentVCGK:(NSInteger)index;


@property (nonatomic, assign) CGFloat offset;


@end
