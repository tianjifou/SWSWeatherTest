//
//  CityWeatherVo.h
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityWeatherVo : NSObject
@property(nonatomic,copy)NSString*s_currentCity;//城市
@property(nonatomic,copy)NSString*s_pm25;//温度
@property(nonatomic,strong)NSArray*a_index;//天气指数内容
@property(nonatomic,strong)NSArray*a_weatherData;//星期内容

/**
 *
 *  此方法通过一个属性字段生成一个类名字符串
 *  @param aStr 实体类的属性字符串，该属性表示聚合一个类集合
 *  @return 一个实体类类名字符串
 *
 */
+(NSString *)getClassesNameFromAttribute:(NSString *)aStr;
@end
