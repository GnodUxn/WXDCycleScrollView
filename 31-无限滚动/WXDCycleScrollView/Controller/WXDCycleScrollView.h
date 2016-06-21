//
//  WXDCycleScrollView.h
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXDCycleScrollView : UIView

/**
 *  用来存放数据模型
 */
@property (nonatomic, strong) NSMutableArray *newses;

/**
 *  移除定时器
 */
- (void)removeTimer;

@end
