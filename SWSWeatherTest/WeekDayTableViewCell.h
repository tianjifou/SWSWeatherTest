//
//  WeekDayTableViewCell.h
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/8.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeatherVo;
@interface WeekDayTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;

-(void)setCell:(WeatherVo*)weatherVo;
@end
