//
//  ViewController.m
//  ProvinceCityArea
//
//  Created by 赵海明 on 2018/4/12.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import "ViewController.h"
#import "HmSelectAdView.h"

@interface ViewController ()

@property (nonatomic, strong) NSString *currentProvince;
@property (nonatomic, strong) NSString *currentCity;
@property (nonatomic, strong) NSString *currentArea;

@property (nonatomic, strong) UILabel *lbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"地址选择";
    
    self.lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 2 - 100, self.view.frame.size.width, 30)];
    _lbl.textColor = [UIColor blackColor];
    _lbl.textAlignment = NSTextAlignmentCenter;
    _lbl.text = @"无选择";
    [self.view addSubview:_lbl];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(40, CGRectGetMaxY(_lbl.frame) + 40, self.view.frame.size.width - 80, 40);
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn setTitle:@"click" forState:(UIControlStateNormal)];
    [btn setBackgroundColor:[UIColor lightGrayColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(clickBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}


/// 点击
- (void)clickBtnAction:(UIButton *)btn {
    HmSelectAdView *selectV = [[HmSelectAdView alloc] initWithLastContent:self.currentProvince ? @[self.currentProvince, self.currentCity, self.currentArea] : nil];
    selectV.confirmSelect = ^(NSArray *address) {
        self.currentProvince = address[0];
        self.currentCity = address[1];
        self.currentArea = address[2];
        self.lbl.text = [NSString stringWithFormat:@"%@ %@ %@", self.currentProvince, self.currentCity, self.currentArea];
    };
    [selectV show];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
