//
//  WeekWeatherListCell.h
//  AppleWeatherDemo
//
//  Created by 许必杨 on 2018/8/15.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekWeatherListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@end
