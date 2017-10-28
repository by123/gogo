//
//  HistoryPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "HistoryPage.h"
#import "BarView.h"

@interface HistoryPage ()

@property(strong, nonatomic) BarView *barView;

@end

@implementation HistoryPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"竞猜历史" page:self];
    [self.view addSubview:_barView];
}

@end
