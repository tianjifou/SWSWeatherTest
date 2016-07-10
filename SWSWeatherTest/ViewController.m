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
@interface ViewController ()<UITextFieldDelegate>
{
    UITextField*textField;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton*btn = [[UIButton alloc]init];
    [btn setTitle:@"查询" forState:UIControlStateNormal];
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
    
    textField = [[UITextField alloc]init];
    textField.placeholder = @"请输入城市名";
    textField.textColor = [UIColor blueColor];
    textField.layer.cornerRadius = 4;
    textField.layer.borderWidth = 2;
    textField.delegate = self;
    textField.layer.borderColor = [UIColor blueColor].CGColor;
   
    [self.view addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(btn);
        make.bottom.equalTo(btn.mas_top).with.offset(-20);
         make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
     [self.view endEditing:YES];
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(void)pushVC {
    if(textField.text.length>0){
        WeatherViewController*vc=[[WeatherViewController alloc]init];
        vc.city = textField.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self alertView];
    }
    
}
-(void)alertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确内容" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
