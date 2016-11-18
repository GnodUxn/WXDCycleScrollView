//
//  ViewController.m
//  31-无限滚动
//
//  Created by 万旭东 on 16/6/18.
//  Copyright © 2016年 WXD. All rights reserved.
//

#import "ViewController.h"
#import "WXDCycleScrollView.h"
#import "WXDNews.h"
#import "UIView+Extension.h"

@interface ViewController () <WXDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    WXDCycleScrollView *_cycleScrollView;
    UITableView *_tableView;
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *newses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"test";
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBarHidden = YES;
//    self.navigationController.navigationBar.alpha = 0;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
//    tableView.bounces = NO;
    
    WXDCycleScrollView *cycleScrollView = [[WXDCycleScrollView alloc] init];
    cycleScrollView.newses = self.newses;
    cycleScrollView.delegate = self;
    cycleScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, 250);
    _cycleScrollView = cycleScrollView;
    tableView.tableHeaderView = _cycleScrollView;
    
    [self.view addSubview:_tableView];
}


- (NSMutableArray *)newses
{
    if (!_newses) {
        _newses = [NSMutableArray array];
        for (int i = 1; i <= 3; i++) {
            WXDNews *new = [[WXDNews alloc] init];
            new.title = [NSString stringWithFormat:@"%d",i];
            new.picture = [NSString stringWithFormat:@"%d.jpg",i];
            [_newses addObject:new];
        }
    }

    return _newses;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"哈哈哈😄";
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY > 0) {
        self.navigationController.navigationBarHidden = NO;
        self.navigationController.navigationBar.alpha = contentOffsetY / 180;
    }else if (contentOffsetY <= 0){
        self.navigationController.navigationBarHidden = YES;
//        _tableView.contentOffset = CGPointZero;
    }
}

#pragma mark WXDCycleScrollViewDelegate
- (void)WXDCycleScrollView:(WXDCycleScrollView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d",indexPath.item);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
