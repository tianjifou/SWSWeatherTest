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
@interface WeatherViewController (){
    NSMutableArray* dataArr;
}

@end

@implementation WeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"上海市";
    
    UIImageView*backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"storm-010"]];
    backImageView.frame = self.view.bounds;
    [self.view addSubview:backImageView];
    
    UILabel*label = [[UILabel alloc]init];
    label.text = @"30°c";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    UITableView*table = [[UITableView alloc]init];
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.rowHeight = 50;
    [self.view addSubview:table];
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.and.right.equalTo(self.view);
        make.top.equalTo(label.mas_bottom).with.offset(20);
    
    }];
    
    [table registerNib:[UINib nibWithNibName:@"WeekDayTableViewCell" bundle:nil] forCellReuseIdentifier:@"weekCell"];
    dataArr = [[NSMutableArray alloc]init];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WeekDayTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"weekCell" forIndexPath:indexPath];
    if(!cell){
        cell = [[WeekDayTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"weekCell"];
      
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
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
