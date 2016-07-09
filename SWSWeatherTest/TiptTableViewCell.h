//
//  TiptTableViewCell.h
//  SWSWeatherTest
//
//  Created by 天机否 on 16/7/9.
//  Copyright © 2016年 天机否. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TiptVo;
@interface TiptTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiptLabel;
@property (weak, nonatomic) IBOutlet UILabel *tiptDesLabel;
-(void)setCell:(TiptVo*)tiptVo;
@end
