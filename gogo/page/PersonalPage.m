//
//  PersonalPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "PersonalPage.h"
#import "BarView.h"

@interface PersonalPage ()

@property(strong, nonatomic) BarView *barView;

@end

@implementation PersonalPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"个人信息" page:self];
    [self.view addSubview:_barView];
}

@end
