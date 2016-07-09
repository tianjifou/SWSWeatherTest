//
//  RequestTool.h
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;
@interface RequestTool : NSObject
/**
 *
 *  此方法get请求
 *  @param url 请求url NSString
 *  @param param 请求参数 NSDictionary
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 *  @param needDefaultFail 是否需要弹窗提示异常
 *  @return 无返回结果
 *
 */
+(void)getRequest:(NSString*)urlStr withParam:(NSDictionary*)param success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorBlock  needDefaultFail:(BOOL)need;

/**
 *
 *  此方法post请求
 *  @param url 请求url NSString
 *  @param param 请求参数 NSDictionary
 *  @param successBlock 成功回调
 *  @param errorBlock   失败回调
 *  @param need 是否需要默认error提示
 *  @return 无返回结果
 *
 */
+(void)postRequest:(NSString*)urlStr withParam:(NSDictionary*)param success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorBlock needDefaultFail:(BOOL)need;
/**
 *
 *  此方法生成Vo
 *  @param s 一个字符串
 *  @return 生成对应的modelvo
 *
 */
+(NSString *)capitalizedString:(NSString *)s;

/**
 *
 *  此方法通过一个字典的句柄生成一个实体类
 *  @param aDict 一个字典句柄
 *  @param classStr 实体类的类名
 *  @return 生成的实体类
 *
 */
+(NSObject *)encapsulationObjectFromDict:(NSDictionary *)aDict toClass:(NSString *)classStr;
@end
