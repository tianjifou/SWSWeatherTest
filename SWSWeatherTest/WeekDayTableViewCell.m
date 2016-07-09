//
//  WeekDayTableViewCell.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/8.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "WeekDayTableViewCell.h"
#import "WeatherVo.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation WeekDayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCell:(WeatherVo*)weatherVo {
    _weekDayLabel.text = [weatherVo.s_date substringToIndex:2];
    [_weatherImage sd_setImageWithURL:[NSURL URLWithString:weatherVo.s_dayPictureUrl]];
    _temperatureLabel.text = weatherVo.s_temperature;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
