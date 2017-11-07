//
//  DMScrolSegmentView.h
//  DM
//
//  Created by dm on 16/8/26.
//  Copyright © 2016年 dm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTScrolSegmentView : UIView

- (void)show;

- (instancetype)initWithControllers:(NSArray<UITableViewController *> *)controllers titles:(NSArray<NSString *> *)titles;

//这个点击事件去判断全局偏移量的设定，然后根据位置进行设定
- (void)jumpCoumMentVC6:(NSInteger)index;


@property (nonatomic, assign) CGFloat offset;

@end
