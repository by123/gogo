//
//  AboutPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "AboutPage.h"
#import "BarView.h"

@interface AboutPage ()

@property(strong, nonatomic) BarView *barView;

@end

@implementation AboutPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"关于" page:self];
    [self.view addSubview:_barView];
}

@end
