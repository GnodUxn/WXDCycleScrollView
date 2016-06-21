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

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *newses;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WXDCycleScrollView *cycleScrollView = [[WXDCycleScrollView alloc] init];
    cycleScrollView.newses = self.newses;
    cycleScrollView.frame = CGRectMake(0, 20, self.view.frame.size.width, 150);
    [self.view addSubview:cycleScrollView];
}


- (NSMutableArray *)newses
{
    if (!_newses) {
        _newses = [NSMutableArray array];
        for (int i = 1; i <= 6; i++) {
            WXDNews *new = [[WXDNews alloc] init];;
            new.title = [NSString stringWithFormat:@"%d",i];
            new.picture = [NSString stringWithFormat:@"icon%d.jpg",i];
            [_newses addObject:new];
        }
    }
    return _newses;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
