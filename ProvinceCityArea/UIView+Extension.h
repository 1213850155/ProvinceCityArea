//
//  UIView+Extension.h
//  FrameTest
//
//  Created by 赵海明 on 2017/2/21.
//  Copyright © 2017年 赵海明. All rights reserved.
//

#import <UIKit/UIKit.h>

#define vAlertTag    10086

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat hm_x;
@property (nonatomic, assign) CGFloat hm_y;
@property (nonatomic, assign) CGFloat hm_centerX;
@property (nonatomic, assign) CGFloat hm_centerY;
@property (nonatomic, assign) CGFloat hm_width;
@property (nonatomic, assign) CGFloat hm_height;
@property (nonatomic, assign) CGSize hm_size;
@property (nonatomic, assign) CGPoint hm_origin;

@property (nonatomic, assign) CGFloat hm_bottom;
@property (nonatomic, assign) CGFloat hm_right;

@property (nonatomic, readonly) UIViewController *hm_viewController;   // 获取当前视图的Controller

@end
