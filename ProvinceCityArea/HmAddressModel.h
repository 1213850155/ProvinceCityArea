//
//  HmAddressModel.h
//  AiaiWang
//
//  Created by 赵海明 on 2018/3/27.
//  Copyright © 2018年 cnmobi. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HmAddressCityModel.h"

@interface HmAddressModel : JSONModel

@property (nonatomic, strong) NSString<Optional> *name;
@property (nonatomic, strong) NSArray<HmAddressCityModel, Optional> *city;

@end
