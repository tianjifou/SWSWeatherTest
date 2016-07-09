//
//  RequestTool.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "RequestTool.h"
#import <AFNetworking/AFNetworking.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "CityWeatherVo.h"
@implementation RequestTool

+(void)getRequest:(NSString*)urlStr withParam:(NSDictionary*)param success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorBlock  needDefaultFail:(BOOL)need{
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableDictionary * requestParam=[param mutableCopy];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
        [client getPath:nil parameters:requestParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (successBlock) {
            successBlock(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (need) {
           
            NSLog(@"%@",error.localizedDescription);
            
        }
        if (errorBlock) {
            errorBlock(operation,error);
        }
    }];
    
    return ;
    
}

+(void)postRequest:(NSString*)urlStr withParam:(NSDictionary*)param success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))errorBlock needDefaultFail:(BOOL)need{
   
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableDictionary * requestParam=[param mutableCopy];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:url];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
       [client postPath:nil parameters:requestParam success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (successBlock) {
            successBlock(operation,responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
       NSLog(@"fffffff%@",error.localizedDescription);
        if (errorBlock) {
            errorBlock(operation,error);
        }
    }];
    return ;
}

+(NSString *)capitalizedString:(NSString *)s {
    if (!s) {
        return nil;
    }else if (s.length>1) {
        return[NSString stringWithFormat:@"%@%@Vo", [[s substringToIndex:1] uppercaseString],[s substringFromIndex:1]];
    }else{
        return [NSString stringWithFormat:@"%@Vo",[s uppercaseString]];
    }
}

/**
 *
 *  此方法通过一个字典的句柄生成一个实体类
 *  @param aDict 一个字典句柄
 *  @param classStr 实体类的类名
 *  @return 生成的实体类
 *
 */
+(NSObject *)encapsulationObjectFromDict:(NSDictionary *)aDict toClass:(NSString *)classStr{
    
    
    int (*action)(id, SEL, NSObject*) = (int (*)(id, SEL, NSObject*)) objc_msgSend;
    
    if (!aDict||![aDict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    id resultObj=nil;
    resultObj=[[NSClassFromString(classStr) alloc] init];
    if (!resultObj) {
        return aDict;
    }
    for(int i=0;i<[aDict count];i++){
        NSString * keyStr=[[aDict allKeys] objectAtIndex:i];
        NSObject * valueObj=[aDict objectForKey:keyStr];
        if(valueObj){
            if(![valueObj isKindOfClass:[NSDictionary class]] &&
               ![valueObj isKindOfClass:[NSArray class]] &&
               ![valueObj isKindOfClass:[NSNull class]]&&[resultObj respondsToSelector:NSSelectorFromString([RequestTool getSetterStr:keyStr])]){
                NSString * string=[NSString stringWithFormat:@"%@",valueObj];
                action(resultObj, NSSelectorFromString([RequestTool getSetterStr:keyStr]),string);
                
            } else if([[aDict objectForKey:keyStr] isKindOfClass:[NSArray class]]&&[resultObj respondsToSelector:NSSelectorFromString([RequestTool getSetterStr:keyStr type:@"a"])]){
                NSArray * classArray=(NSArray *)valueObj;
                NSMutableArray * performArray=[NSMutableArray array];
                for(int x=0;x<[classArray count];x++){
                    if([[classArray objectAtIndex:x] isKindOfClass:[NSDictionary class]]){
                        NSObject * performObj=nil;
                        
                            NSString* classStr=@"";
                            if ([resultObj isKindOfClass:[CityWeatherVo class]]) {
                                classStr=[CityWeatherVo getClassesNameFromAttribute:keyStr];
                            }else{
                                classStr=[CityWeatherVo getClassesNameFromAttribute:keyStr];
                            }
                            performObj=[RequestTool encapsulationObjectFromDict: (NSDictionary *)[classArray objectAtIndex:x]
                                                                        toClass: classStr];
                        
                        if (performObj) {
                            [performArray addObject:performObj];
                        }
                    } else if([[classArray objectAtIndex:x] isKindOfClass:[NSString class]]){
                        [performArray addObject:[classArray objectAtIndex:x]];
                    }else if([[classArray objectAtIndex:x] isKindOfClass:[NSNumber class]]){
                        [performArray addObject:[NSString stringWithFormat:@"%@",[classArray objectAtIndex:x]]];
                    }
                }
                action(resultObj, NSSelectorFromString([RequestTool getSetterStr:keyStr type:@"a"]),performArray);
                performArray=nil;
            }
            
        }
    }
    return resultObj;
}
/**
 *
 *  此方法通过一个属性字段生成一个setter字符串
 *  @param attributeStr 实体类的属性字符串
 *  @return 一个setter字符串
 *
 */
+(NSString *)getSetterStr:(NSString *)attributeStr{
    
    if (!attributeStr) {
        return nil;
    }
  
   
    attributeStr=[RequestTool convertToxxXxxString:attributeStr];
    return [NSString stringWithFormat:@"setS_%@:",attributeStr];
   
}

/**
 *
 *  此方法消除字符串中的下划线
 *  @param xiahuaxian 一个字符串
 *  @return 生成没有下划线的字符串
 *
 */
+ (NSString*)convertToxxXxxString:(NSString*)xiahuaxian
{
    NSMutableString* mulStr=[NSMutableString stringWithString:xiahuaxian];
    
    for (int i=0; i<mulStr.length; i++) {
        char c=[mulStr characterAtIndex:i];
        if (c == '_') {
            NSRange range=[mulStr rangeOfString:[NSString stringWithFormat:@"%c",c]];
            
            [mulStr deleteCharactersInRange:range];
            
            char b=[mulStr characterAtIndex:range.location];
            
            [mulStr replaceCharactersInRange:range withString:[NSString stringWithFormat:@"%c",b-32]];
            
        }
    }
    return mulStr;
}

/**
 *
 *  此方法通过一个属性字段生成一个setter字符串
 *  @param attributeStr 实体类的属性字符串
 *  @return 一个setter字符串
 *
 */
+(NSString *)getSetterStr:(NSString *)attributeStr type:(NSString *)type{//string是s，array是a，dic是d
    if (!attributeStr) {
        return nil;
    }
   
    attributeStr=[RequestTool convertToxxXxxString:attributeStr];
    return [NSString stringWithFormat:@"set%@_%@:",[type uppercaseString],attributeStr];
}


@end
