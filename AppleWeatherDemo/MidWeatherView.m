//
//  MidWeatherView.m
//  AppleWeatherDemo
//
//  Created by 许必杨 on 2018/8/15.
//  Copyright © 2018年 xby023. All rights reserved.
//

#import "MidWeatherView.h"
#import "MidWeatherListCell.h"
@interface MidWeatherView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation MidWeatherView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
        self.backImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
        self.backImageVIew.contentMode = UIViewContentModeScaleToFill;
        [self insertSubview:self.backImageVIew atIndex:0];
    }
    return self;
}


#pragma mark =========================collectionView dataSource and delegate=======================
// 自定义cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MidWeatherListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MidWeatherListCell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.timeLabel.text = @"现在";
        cell.iconView.image = [UIImage imageNamed:@"多云2"];
        cell.tempLabel.text = @"32°";
    }else if (indexPath.row == 1) {
        cell.timeLabel.text = @"下午2时";
        cell.iconView.image = [UIImage imageNamed:@"多云2"];
        cell.tempLabel.text = @"32°";
    
    }else if (indexPath.row == 2) {
        cell.timeLabel.text = @"下午3时";
        cell.iconView.image = [UIImage imageNamed:@"多云2"];
        cell.tempLabel.text = @"32°";
        
    }else if (indexPath.row == 3) {
        cell.timeLabel.text = @"下午4时";
        cell.iconView.image = [UIImage imageNamed:@"晴2"];
        cell.tempLabel.text = @"32°";
        
    }else if (indexPath.row == 4) {
        cell.timeLabel.text = @"下午5时";
        cell.iconView.image = [UIImage imageNamed:@"晴2"];
        cell.tempLabel.text = @"32°";
        
    }else if (indexPath.row == 5) {
        cell.timeLabel.text = @"下午6时";
        cell.iconView.image = [UIImage imageNamed:@"晴2"];
        cell.tempLabel.text = @"32°";
        
    }else{
        cell.timeLabel.text = @"下午7时";
        cell.iconView.image = [UIImage imageNamed:@"晴2"];
        cell.tempLabel.text = @"32°";
    }
    return cell;
}

// 分区数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

// 每个分区的cell数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

// 自定义item
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(80,120);
}


//每个分组的边缘尺寸

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每个分组的行间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0.f;
    
}

//每个分组的列间距

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}

// 每个分区的头部尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(0, 0);
}

//返回头／尾视图的样式
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


// 点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ====================================getter===================================

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.sectionHeadersPinToVisibleBounds = YES;
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 120) collectionViewLayout:flow];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MidWeatherListCell class]) bundle:nil] forCellWithReuseIdentifier:@"MidWeatherListCell"];
    }
    return _collectionView;
}


@end
