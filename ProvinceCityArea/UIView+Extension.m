//
//  UIView+Extension.m
//  FrameTest
//
//  Created by 赵海明 on 2017/2/21.
//  Copyright © 2017年 赵海明. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (UIViewController *)hm_viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (CGFloat)hm_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setHm_bottom:(CGFloat)hm_bottom {
    CGRect frame = self.frame;
    frame.origin.y = hm_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)hm_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setHm_right:(CGFloat)hm_right {
    CGRect frame = self.frame;
    frame.origin.x = hm_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)hm_x {
    return self.frame.origin.x;
}

- (void)setHm_x:(CGFloat)hm_x {
    CGRect frame = self.frame;
    frame.origin.x = hm_x;
    self.frame = frame;
}

- (CGFloat)hm_y {
    return self.frame.origin.y;
}

- (void)setHm_y:(CGFloat)hm_y {
    CGRect frame = self.frame;
    frame.origin.y = hm_y;
    self.frame = frame;
}

- (CGFloat)hm_centerX {
    return self.center.x;
}

- (void)setHm_centerX:(CGFloat)hm_centerX {
    CGPoint center = self.center;
    center.x = hm_centerX;
    self.center = center;
}

- (CGFloat)hm_centerY {
    return self.center.y;
}

- (void)setHm_centerY:(CGFloat)hm_centerY {
    CGPoint center = self.center;
    center.y = hm_centerY;
    self.center = center;
}

- (CGFloat)hm_width {
    return self.frame.size.width;
}

- (void)setHm_width:(CGFloat)hm_width {
    CGRect frame = self.frame;
    frame.size.width = hm_width;
    self.frame = frame;
}

- (CGFloat)hm_height {
    return self.frame.size.height;
}

- (void)setHm_height:(CGFloat)hm_height {
    CGRect frame = self.frame;
    frame.size.height = hm_height;
    self.frame = frame;
}

- (CGSize)hm_size {
    return self.frame.size;
}

- (void)setHm_size:(CGSize)hm_size {
    CGRect frame = self.frame;
    frame.size = hm_size;
    self.frame = frame;
}

- (CGPoint)hm_origin {
    return self.frame.origin;
}

- (void)setHm_origin:(CGPoint)hm_origin {
    CGRect frame = self.frame;
    frame.origin = hm_origin;
    self.frame = frame;
}

@end
