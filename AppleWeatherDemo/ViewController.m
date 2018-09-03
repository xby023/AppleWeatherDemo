//
//  ViewController.m
//  AppleWeatherDemo
//
//  Created by 许必杨 on 2018/8/14.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "ViewController.h"
// 125   140   120

//当天天气
#import "TodayWeatherCell.h"

//一周天气
#import "MidWeatherView.h"

#import "WeekWeatherListCell.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UILabel *tempLabel;

@property (nonatomic ,strong) UITableView *tableView;

@property (nonatomic ,strong) MidWeatherView *midView ;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navOffY;

@property (nonatomic ,strong) TodayWeatherCell *todayWeatherCell;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initUI{
    
    self.navOffY.constant = 50 + NAVIBAR_Space;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.view addSubview:self.tableView];
    
    MidWeatherView *midView = [[MidWeatherView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    midView.backgroundColor = [UIColor clearColor];
    self.midView = midView;
    
    //分割线
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.5)];
    line1.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [midView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 119.5, ScreenWidth, 0.5)];
    line2.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    [midView addSubview:line2];
    
    self.midView.backImageVIew.image = [self imageWithView:self.backImageView frame:CGRectMake(0, 125 + NAVIBAR_Space, ScreenWidth, 122.5)];
    self.midView.backImageVIew.hidden = YES;
    
}

- (UIImage *)imageWithView:(UIView *)view frame:(CGRect)frame{
    int scale = [UIScreen mainScreen].scale;
    
    CGRect rect = frame;
    rect.origin.x *= scale;
    rect.origin.y *= scale;
    rect.size.width *= scale;
    rect.size.height *= scale;
    
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    [view.layer renderInContext:context];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //  这里是重点, 意思是取范围内的cgimage
    CGImageRef cgImage = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage * newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y >= 60) {
        self.tempLabel.alpha = 0;
    }else{
        self.tempLabel.alpha = 1 - scrollView.contentOffset.y / 60;
    }
    
    if (scrollView.contentOffset.y >= 45) {
        self.todayWeatherCell.alpha = 0;
    }else{
        self.todayWeatherCell.alpha = 1 - scrollView.contentOffset.y / 45;
    }
    
    if (scrollView.contentOffset.y >= 140) {
        self.navOffY.constant = 50 + NAVIBAR_Space - 5;
        self.midView.backImageVIew.hidden = NO;
    }else{
        self.midView.backImageVIew.hidden = YES;
        self.navOffY.constant = 50 + NAVIBAR_Space - 5 * scrollView.contentOffset.y / 140;
    }
}


#pragma mark ====================================delegate===================================

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section != 0) {
        
        WeekWeatherListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeekWeatherListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        if (indexPath.row % 7 == 0) {
            cell.timeLabel.text = @"星期四";
            cell.iconView.image = [UIImage imageNamed:@"多云2"];
            cell.tempLabel.text = @"32°";
        }else if (indexPath.row % 7 == 1) {
            cell.timeLabel.text = @"星期五";
            cell.iconView.image = [UIImage imageNamed:@"云"];
            cell.tempLabel.text = @"32°";
            
        }else if (indexPath.row % 7 == 2) {
            cell.timeLabel.text = @"星期六";
            cell.iconView.image = [UIImage imageNamed:@"多云2"];
            cell.tempLabel.text = @"32°";
            
        }else if (indexPath.row % 7 == 3) {
            cell.timeLabel.text = @"星期日";
            cell.iconView.image = [UIImage imageNamed:@"晴2"];
            cell.tempLabel.text = @"32°";
            
        }else if (indexPath.row % 7 == 4) {
            cell.timeLabel.text = @"星期一";
            cell.iconView.image = [UIImage imageNamed:@"多云2"];
            cell.tempLabel.text = @"32°";
            
        }else if (indexPath.row % 7 == 5) {
            cell.timeLabel.text = @"星期二";
            cell.iconView.image = [UIImage imageNamed:@"晴2"];
            cell.tempLabel.text = @"32°";
            
        }else{
            cell.timeLabel.text = @"星期三";
            cell.iconView.image = [UIImage imageNamed:@"云"];
            cell.tempLabel.text = @"32°";
        }
        
        return cell;
    }else{
        TodayWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodayWeatherCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        self.todayWeatherCell = cell;
        return cell;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 14;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 140;
    }else{
        return 36;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 120;
    }else{
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.midView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    
    
    
}

#pragma mark ====================================getter===================================

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,125 + NAVIBAR_Space, ScreenWidth, ScreenHeight - 125 - NAVIBAR_Space)];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource  = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TodayWeatherCell class]) bundle:nil] forCellReuseIdentifier:@"TodayWeatherCell"];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WeekWeatherListCell class]) bundle:nil] forCellReuseIdentifier:@"WeekWeatherListCell"];
        
        
    }
    return _tableView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
