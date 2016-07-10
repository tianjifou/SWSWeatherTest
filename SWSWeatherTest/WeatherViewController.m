//
//  WeatherViewController.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/8.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "WeatherViewController.h"
#import <Masonry/Masonry.h>
#import "WeekDayTableViewCell.h"
#import "TiptTableViewCell.h"
#import "RequestTool.h"
#import "CityWeatherVo.h"
#import "WeatherVo.h"
#import "TiptVo.h"
#import <POP.h>

#define AK @"nTZHDUGA4aRaGrEXbhaXousx"
#define  WEATHER_URL @"http://api.map.baidu.com/telematics/v3/weather"
@interface WeatherViewController (){
    NSMutableArray* dataArr;
    UITableView*table;
    UILabel*labelT;
    CityWeatherVo*weather;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.city;
    
    UIImageView*backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"storm-010"]];
    backImageView.frame = self.view.bounds;
    [self.view addSubview:backImageView];
    
    labelT = [[UILabel alloc]init];
    labelT.text = @"0°F";
    labelT.textColor = [UIColor whiteColor];
    labelT.font = [UIFont systemFontOfSize:30];
    labelT.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelT];
    [labelT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    table = [[UITableView alloc]init];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    [self.view addSubview:table];
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.equalTo(labelT.mas_bottom).with.offset(20);
    
    }];
    
    [table registerNib:[UINib nibWithNibName:@"WeekDayTableViewCell" bundle:nil] forCellReuseIdentifier:@"weekCell"];
    [table registerNib:[UINib nibWithNibName:@"TiptTableViewCell" bundle:nil] forCellReuseIdentifier:@"tiptCell"];
    dataArr = [[NSMutableArray alloc]init];
    
    [self downloadData];
    
}

-(void)createPopAnimation:(int)num {
    POPBasicAnimation *animation = [POPBasicAnimation animation];
    animation.property = [self animationProperty];
    animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.12 :1: 0.11:0.94];
    animation.fromValue = @(0);
    
    animation.toValue =@(num);
    
    animation.duration = 2;
    
    [labelT pop_addAnimation:animation forKey:@"numberLabelAnimation"];
}
/**
 *  数字滚动时调用方法
 *
 *  @return
 */
- (POPMutableAnimatableProperty *)animationProperty {
    return [POPMutableAnimatableProperty
            propertyWithName:@"test"
            initializer:^(POPMutableAnimatableProperty *prop) {
                prop.writeBlock = ^(id obj, const CGFloat values[]) {
                    UILabel *label = (UILabel *)obj;
                    NSNumber *number = @(values[0]);
                    int num = [number intValue];
                    label.text = [[@(num) stringValue] stringByAppendingString:@"°F"];
                    
                };
            }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataArr.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([dataArr[indexPath.row] isKindOfClass:[WeatherVo class]]) {
        WeekDayTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"weekCell" forIndexPath:indexPath];
        if(!cell){
            cell = [[WeekDayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weekCell"];
            
        }
//        [cell setCell:dataArr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;

    } else {
        TiptTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"tiptCell" forIndexPath:indexPath];
        if(!cell){
            cell = [[TiptTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tiptCell"];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([dataArr[indexPath.row] isKindOfClass:[WeatherVo class]]) {
        return 80;
    }else {
        return 130;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([dataArr[indexPath.row] isKindOfClass:[WeatherVo class]]) {
        [(WeekDayTableViewCell*)cell setCell:dataArr[indexPath.row]];
    }else {
        [(TiptTableViewCell*)cell setCell:dataArr[indexPath.row]];
    }
}

-(void)downloadData {
    [RequestTool getRequest:WEATHER_URL withParam:@{@"location":self.city,@"output":@"json",@"ak":AK} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
         NSDictionary *dic1 = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
         weather = (CityWeatherVo*)[RequestTool encapsulationObjectFromDict:dic1[@"results"][0] toClass:@"CityWeatherVo"];
        if(weather){
             [dataArr addObjectsFromArray:weather.a_weatherData];
            [dataArr addObjectsFromArray:weather.a_index];
            [self createPopAnimation:[weather.s_pm25 intValue]];
           
        }else {
             [self alertView];
        }
        [table reloadData];
      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [self alertView];
    } needDefaultFail:YES];
}

-(void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"网络异常或者你输入有误" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
