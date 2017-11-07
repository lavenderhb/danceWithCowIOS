//
//  DMScrolSegmentView.h
//  DM
//
//  Created by dm on 16/8/26.
//  Copyright © 2016年 dm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMScrolSegmentView : UIView

- (void)show;

//这个点击事件判断事情的发生
- (void)jumpCoumMentVC:(NSInteger)index;


- (instancetype)initWithControllers11:(NSArray<UIViewController *> *)controllers titles:(NSArray<NSString *> *)titles;



@property (nonatomic, assign) CGFloat offset;

@end
