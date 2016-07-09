//
//  TiptTableViewCell.m
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import "TiptTableViewCell.h"
#import "TiptVo.h"
@implementation TiptTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCell:(TiptVo*)tiptVo {
    _titleLabel.text = tiptVo.s_title;
    _titleDesLabel.text = tiptVo.s_zs;
    _tiptLabel.text = tiptVo.s_tipt;
    _tiptDesLabel.text = tiptVo.s_des;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
