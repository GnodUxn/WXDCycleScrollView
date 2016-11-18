//
//  WXDNewsCell.m
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import "WXDNewsCell.h"
#import "WXDNews.h"

@interface WXDNewsCell ()


@end

@implementation WXDNewsCell

//重写构造方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        self.pictureView = pictureView;
        pictureView.contentMode = UIViewContentModeScaleAspectFill;
        //添加到父视图collertionViewCell上面
        [self.contentView addSubview:self.pictureView];
        
        UILabel *titleLabe = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
        titleLabe.textAlignment = NSTextAlignmentCenter;
        titleLabe.textColor = [UIColor whiteColor];
        titleLabe.backgroundColor = [UIColor blackColor];
        titleLabe.alpha = 0.3;
        titleLabe.font = [UIFont systemFontOfSize:22.0];
//        titleLabe.backgroundColor = [UIColor clearColor];
        self.titleLabe = titleLabe;
        //添加到父视图collertionViewCell上面
//        [self.pictureView addSubview:self.titleLabe];
    }
    return self;
}


- (void)setNews:(WXDNews *)news
{
    _news = news;
    
    self.pictureView.image = [UIImage imageNamed:_news.picture];
    self.titleLabe.text = _news.title;
}

@end
