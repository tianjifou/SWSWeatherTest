//
//  WeatherVo.h
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherVo : NSObject
@property(nonatomic,copy)NSString*s_date;//日期
@property(nonatomic,copy)NSString*s_dayPictureUrl;//白天天气图片
@property(nonatomic,copy)NSString*s_nightPictureUrl;//晚上天气图片
@property(nonatomic,copy)NSString*s_weather;//天气状态
@property(nonatomic,copy)NSString*s_wind;//风力
@property(nonatomic,copy)NSString*s_temperature;//温度
@end
