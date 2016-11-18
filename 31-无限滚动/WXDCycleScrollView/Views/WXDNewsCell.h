//
//  WXDNewsCell.h
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXDNews;

@interface WXDNewsCell : UICollectionViewCell

@property (weak, nonatomic) UILabel *titleLabe;
@property (weak, nonatomic) UIImageView *pictureView;

/**
 *  用来接收新闻模型
 */
@property (nonatomic, strong) WXDNews *news;

@end
