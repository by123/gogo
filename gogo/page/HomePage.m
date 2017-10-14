//
//  OnePage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "HomePage.h"
#import "SDCycleScrollView.h"


#define AdViewHeight 220
#define AdInterval 3.0f

@interface HomePage ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)initView{
    
    [self initAd];
    [self initBody];
}


-(void)initAd{
    NSArray *images = @[@"http://game.gtimg.cn/images/yxzj/match/img1.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/kcc/kcc.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/img2.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/img3.jpg"
                        ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, AdViewHeight) imagesGroup:images];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = AdInterval;
    [self.view addSubview:cycleScrollView];
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}


-(void)initBody{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 220, ScreenWidth, ScreenHeight - 220);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    return cell;
}

@end
