//
//  ExchangePage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ExchangePage.h"
#import "BarView.h"

@interface ExchangePage ()

@property(strong, nonatomic) BarView *barView;

@end

@implementation ExchangePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"兑换记录" page:self];
    [self.view addSubview:_barView];
}

@end
