//
//  CityWeatherVo.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "CityWeatherVo.h"
#import "RequestTool.h"
@implementation CityWeatherVo

+(NSString *)getClassesNameFromAttribute:(NSString *)aStr{
    
    if ([aStr isEqualToString:@"weather_data"]) {
        return @"WeatherVo";
    }
    if ([aStr isEqualToString:@"index"]) {
        return @"TiptVo";
    }
    
    return [RequestTool capitalizedString:aStr];
    
   
}
@end
