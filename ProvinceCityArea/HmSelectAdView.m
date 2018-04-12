//
//  HmSelectAdView.m
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/28.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import "HmSelectAdView.h"
#import "HmAddressModel.h"
#import "UIView+Extension.h"

#define kPickerViewHeight 200
#define kTitleHeight 30
/*** RGB颜色 */
#define HmColorRGB(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
/*** RGBA颜色 */
#define HmColorRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:(a)]
// 屏幕的width
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
// 屏幕的height
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HmSelectAdView()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UIPickerView *pickerV;
@property (nonatomic, strong) NSArray *allDataArr;
@property (nonatomic, strong) NSMutableArray *provinceArr;
@property (nonatomic, strong) NSMutableArray *cityArr;
@property (nonatomic, strong) NSMutableArray *areaArr;

@property (nonatomic, strong) NSString *currentSelectProvince;
@property (nonatomic, strong) NSString *currentSelectCity;
@property (nonatomic, strong) NSString *currentSelectArea;

// 布局控件
@property (nonatomic, strong) UIButton *bgV;

@end

@implementation HmSelectAdView

- (instancetype)initWithLastContent:(NSArray *)lastContent {
    if ([super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        if (lastContent) {
            self.currentSelectProvince = lastContent.firstObject;
            self.currentSelectCity = lastContent[1];
            self.currentSelectArea = lastContent.lastObject;
        }
        [self setupView];
        [self HmGetArea];
    }
    return self;
}

- (void)show {
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

#pragma mark -- UIPickerView Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr.count;
    }else if (component == 1) {
        return self.cityArr.count;
    }else {
        return self.areaArr.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArr[row];
    }else if (component == 1) {
        return self.cityArr[row];
    }else {
        return self.areaArr[row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 30;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.currentSelectProvince = self.provinceArr[row];
        self.currentSelectCity = nil;
        self.currentSelectArea = nil;
        [self calculationCityAreaArr];
        [pickerView selectRow:[self.cityArr indexOfObject:self.currentSelectCity] inComponent:1 animated:YES];
        [pickerView selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
    }else if (component == 1) {
        self.currentSelectCity = self.cityArr[row];
        self.currentSelectArea = nil;
        [self calculationCityAreaArr];
        [pickerView selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
    }else {
        self.currentSelectArea = self.areaArr[row];
    }
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (!view) {
        view = [[UIView alloc] init];
    }
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (kScreenWidth - 50) / 3, 30)];
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:15];
    lblTitle.textColor = HmColorRGB(51, 51, 51);
    if (component == 0) {
        lblTitle.text = self.provinceArr[row];
    }else if (component == 1) {
        lblTitle.text = self.cityArr[row];
    }else {
        lblTitle.text = self.areaArr[row];
    }
    [view addSubview:lblTitle];
    return view;
}

#pragma mark -- Functions
/// 设置view
- (void)setupView {
    // 背景
    self.bgV = [UIButton buttonWithType:(UIButtonTypeSystem)];
    _bgV.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _bgV.backgroundColor = HmColorRGBA(0, 0, 0, 0.4);
    [_bgV setTitle:@"" forState:(UIControlStateNormal)];
    [_bgV addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:_bgV];
    // 承载view
    UIView *vv = [[UIView alloc] initWithFrame:CGRectMake(20, (kScreenHeight - kPickerViewHeight - 80) / 2, kScreenWidth - 40, kPickerViewHeight + 80)];
    vv.layer.cornerRadius = 10;
    vv.layer.masksToBounds = YES;
    vv.backgroundColor = [UIColor whiteColor];
    [self addSubview:vv];
    // title
    UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, vv.hm_width, kTitleHeight)];
    lblTitle.textColor = HmColorRGB(51, 51, 51);
    lblTitle.backgroundColor = [UIColor clearColor];
    lblTitle.text = @"选择邮寄地区";
    lblTitle.textAlignment = NSTextAlignmentCenter;
    lblTitle.font = [UIFont systemFontOfSize:14];
    [vv addSubview:lblTitle];
    // PickerView
    self.pickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, lblTitle.hm_bottom, vv.hm_width, kPickerViewHeight)];
    self.pickerV.frame = CGRectMake(0, lblTitle.hm_bottom, vv.hm_width, kPickerViewHeight);
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;
    self.pickerV.backgroundColor = [UIColor clearColor];
    [vv addSubview:_pickerV];
    // 分割线(横)
    UILabel *lblLineH = [[UILabel alloc] initWithFrame:CGRectMake(0, _pickerV.hm_bottom, vv.hm_width, 1)];
    lblLineH.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [vv addSubview:lblLineH];
    // 取消
    UIButton *btnCancel = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btnCancel.frame = CGRectMake(0, lblLineH.hm_bottom, vv.hm_width / 2 - 0.5, vv.hm_height - lblLineH.hm_bottom);
    btnCancel.backgroundColor = [UIColor clearColor];
    [btnCancel setTitle:@"取消" forState:(UIControlStateNormal)];
    [btnCancel setTitleColor:HmColorRGB(102, 102, 102) forState:(UIControlStateNormal)];
    [btnCancel addTarget:self action:@selector(cancelAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [vv addSubview:btnCancel];
    // 分割线(竖)
    UILabel *lblLineV = [[UILabel alloc] initWithFrame:CGRectMake(btnCancel.hm_right, lblLineH.hm_bottom, 1, btnCancel.hm_height)];
    lblLineV.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [vv addSubview:lblLineV];
    // 确定
    UIButton *btnSure = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btnSure.frame = CGRectMake(lblLineV.hm_right, lblLineH.hm_bottom, vv.hm_width - lblLineV.hm_right, btnCancel.hm_height);
    btnSure.backgroundColor = [UIColor clearColor];
    [btnSure setTitle:@"确定" forState:(UIControlStateNormal)];
    [btnSure setTitleColor:HmColorRGB(83, 184, 255) forState:(UIControlStateNormal)];
    [btnSure addTarget:self action:@selector(sureAction:) forControlEvents:(UIControlEventTouchUpInside)];
    btnSure.titleLabel.font = [UIFont systemFontOfSize:15];
    [vv addSubview:btnSure];
}

/// 取消
- (void)cancelAction:(UIButton *)btn {
    [self removeFromSuperview];
}

/// 确定
- (void)sureAction:(UIButton *)btn {
    if (self.confirmSelect) {
        self.confirmSelect(@[self.currentSelectProvince, self.currentSelectCity, self.currentSelectArea]);
    }
    [self removeFromSuperview];
}

/// 解析地址
- (void)HmGetArea {
    [self removeAllObjectFromArea];
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"aiai_area.txt" ofType:nil]];
    if (!data) {
        return;
    }
    NSArray *allArr = [HmAddressModel arrayOfModelsFromData:data error:nil];
    self.allDataArr = [NSArray arrayWithArray:allArr];
    [self calculationCityAreaArr];
    [self.pickerV selectRow:[self.provinceArr indexOfObject:self.currentSelectProvince] inComponent:0 animated:YES];
    [self.pickerV selectRow:[self.cityArr indexOfObject:self.currentSelectCity] inComponent:1 animated:YES];
    [self.pickerV selectRow:[self.areaArr indexOfObject:self.currentSelectArea] inComponent:2 animated:YES];
}

/// 清空当前数据
- (void)removeAllObjectFromArea {
    [self.provinceArr removeAllObjects];
    [self.cityArr removeAllObjects];
    [self.areaArr removeAllObjects];
}

/// 计算当前市区数组
- (void)calculationCityAreaArr {
    [self.provinceArr removeAllObjects];
    [self.cityArr removeAllObjects];
    [self.areaArr removeAllObjects];
    if (!self.currentSelectProvince) {
        self.currentSelectProvince = ((HmAddressModel *)self.allDataArr[0]).name;
    }
    for (HmAddressModel *model in self.allDataArr) {
        [self.provinceArr addObject:model.name];
        if ([self.currentSelectProvince isEqualToString:model.name]) {
            if (!self.currentSelectCity) {
                self.currentSelectCity = ((HmAddressCityModel *)model.city[0]).name;
            }
            for (HmAddressCityModel *mo in model.city) {
                [self.cityArr addObject:mo.name];
                if ([mo.name isEqualToString:self.currentSelectCity]) {
                    if (!self.currentSelectArea) {
                        self.currentSelectArea = mo.area.firstObject;
                    }
                    for (NSString *aa in mo.area) {
                        [self.areaArr addObject:aa];
                    }
                }
            }
        }
    }
    [self.pickerV reloadAllComponents];
}

#pragma mark -- Getter
- (NSMutableArray *)provinceArr {
    if (!_provinceArr) {
        _provinceArr = [NSMutableArray array];
    }
    return _provinceArr;
}

- (NSMutableArray *)cityArr {
    if (!_cityArr) {
        _cityArr = [NSMutableArray array];
    }
    return _cityArr;
}

- (NSMutableArray *)areaArr {
    if (!_areaArr) {
        _areaArr = [NSMutableArray array];
    }
    return _areaArr;
}

#pragma mark -- Setter

@end
