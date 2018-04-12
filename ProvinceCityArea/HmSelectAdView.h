//
//  HmSelectAdView.h
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/28.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HmSelectAdView : UIView

@property (nonatomic, copy) void (^confirmSelect)(NSArray *address);
- (instancetype)initWithLastContent:(NSArray *)lastContent;
- (void)show;

@end
