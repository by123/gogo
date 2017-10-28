//
//  AddressPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "AddressPage.h"
#import "BarView.h"

@interface AddressPage ()

@property(strong, nonatomic) BarView *barView;

@end

@implementation AddressPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"地址信息" page:self];
    [self.view addSubview:_barView];
}

@end
