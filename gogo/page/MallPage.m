//
//  MallPage.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MallPage.h"
#import "BySegmentView.h"
#import "GoodsView.h"

@interface MallPage ()

@end

@implementation MallPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    [self initTab];
}

-(void)initTab{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    
    [views addObject:[[GoodsView alloc]initWithType:EQUIPMENT withDelegate:_handleDelegate]];
    [views addObject:[[GoodsView alloc]initWithType:VIRTUAL withDelegate:_handleDelegate]];
    [views addObject:[[GoodsView alloc]initWithType:GAMEAROUND withDelegate:_handleDelegate]];
    [views addObject:[[GoodsView alloc]initWithType:LUCKYMONEY withDelegate:_handleDelegate]];
    [views addObject:[[GoodsView alloc]initWithType:EQUIPMENT withDelegate:_handleDelegate]];

    
    BySegmentView *segmentView = [[BySegmentView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (StatuBarHeight + [PUtil getActualHeight:188])) andTitleArray:@[@"热门商品", @"虚拟物品",@"游戏周边",@"现金红包",@"电竞装备"] andShowControllerNameArray:views];
    [self.view addSubview:segmentView];
}


@end
