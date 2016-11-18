//
//  WXDCycleScrollView.h
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXDCycleScrollView;

@protocol WXDCycleScrollViewDelegate <NSObject>

@optional
/**
 *  轮播图点击事件
 */
- (void)WXDCycleScrollView:(WXDCycleScrollView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WXDCycleScrollView : UIView

/**
 *  设置轮播图的代理
 */
@property (nonatomic, weak) id<WXDCycleScrollViewDelegate> delegate;

/**
 *  用来存放数据模型
 */
@property (nonatomic, strong) NSMutableArray *newses;

/**
 *  移除定时器
 */
- (void)removeTimer;

@end
