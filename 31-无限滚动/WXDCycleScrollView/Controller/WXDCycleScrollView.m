//
//  WXDCycleScrollView.m
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import "WXDCycleScrollView.h"
#import "WXDNewsCell.h"
#import "WXDNews.h"

#define WXDMaxSection 30

@interface WXDCycleScrollView () <UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation WXDCycleScrollView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.UICollectionViewFlowLayout自动布局实例化，实例化UICollectionView时用得着
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView的滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        // 2.创建UICollectionView
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.pagingEnabled = YES;
        collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView = collectionView;
        [self addSubview:self.collectionView];
        
        // 3.注册cell
        [self.collectionView registerClass:[WXDNewsCell class] forCellWithReuseIdentifier:@"collection"];
        
        // 4.添加定时器
        [self addTimer];
        
        // 5.添加pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
//        pageControl.backgroundColor = [UIColor yellowColor];
        self.pageControl = pageControl;
        [self addSubview:pageControl];
    }
    return self;
}

//- (NSMutableArray *)newses
//{
//    if (!_newses) {
//        _newses = [NSMutableArray array];
//        for (int i = 1; i <= 6; i++) {
//            WXDNews *new = [[WXDNews alloc] init];
//            new.title = [NSString stringWithFormat:@"%d",i];
//            new.picture = [NSString stringWithFormat:@"icon%d.jpg",i];
//            [_newses addObject:new];
//        }
//    }
//    
//    return _newses;
//}

/**
 *  添加定时器
 */
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
    // 让定时器在操作UI时也可以滚动
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)nextPage
{
    // 1.当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回中间那组的位置
    NSIndexPath *currentIndexPathReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:WXDMaxSection/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    // 2.计算出下一个需要展示的位置
    NSInteger nextItem = currentIndexPathReset.item + 1;
    NSInteger nextSection = currentIndexPathReset.section;
    if (nextItem == self.newses.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3.滚到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
    // 4.显示pageControl
    self.pageControl.currentPage = nextItem;
}

- (void)layoutSubviews
{
    // 设置collectionView的frame
    CGFloat collectionViewX = 0;
    CGFloat collectionViewY = 0;
    CGFloat collectionViewW = self.frame.size.width;
    CGFloat collectionViewH = self.frame.size.height;
    self.collectionView.frame = CGRectMake(collectionViewX, collectionViewY, collectionViewW, collectionViewH);
    
    // 设置pageControl的frame
    CGFloat pageControlW = self.newses.count * 20;
    CGFloat pageControlH = 30;
    CGFloat pageControlY = self.frame.size.height - pageControlH;
    CGFloat pageControlX = (self.frame.size.width - pageControlW) / 2;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
//    NSLog(@"%@",NSStringFromCGRect(self.pageControl.frame));
    // 设置pageControl个数
    self.pageControl.numberOfPages = self.newses.count;
    // 4.默认显示中间那组
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:WXDMaxSection/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return WXDMaxSection;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count;
}

//设置item大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.frame.size.width, self.frame.size.height);
}

//设置水平最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(WXDCycleScrollView:didSelectItemAtIndexPath:)]) {
        [self.delegate WXDCycleScrollView:self didSelectItemAtIndexPath:indexPath];
    }
}

//必须用自定义的样式，必须用注册的格式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WXDNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    cell.news = self.newses[indexPath.item];
    return cell;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.newses.count;
    self.pageControl.currentPage = page;
}

@end
