//
//  ViewController.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/8.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "WeatherViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton*btn = [[UIButton alloc]init];
    [btn setTitle:@"天气预报" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    btn.layer.borderWidth = 2;
    btn.layer.borderColor = [UIColor blueColor].CGColor;
    [btn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 30));
        
    }];
}

-(void)pushVC {
    WeatherViewController*vc=[[WeatherViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
