//
//  OnePage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "HomePage.h"
#import "SDCycleScrollView.h"
#import "NewsCell.h"


#define AdViewHeight [PUtil getActualHeight:300]
#define AdInterval 3.0f

@interface HomePage ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}


-(void)initView{
   
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - (StatuBarHeight + [PUtil getActualHeight:188]));
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self.view addSubview:_scrollerView];
    
    NSArray *images = @[@"http://game.gtimg.cn/images/yxzj/match/img1.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/kcc/kcc.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/img2.jpg",
                        @"http://game.gtimg.cn/images/yxzj/match/img3.jpg"
                        ];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, AdViewHeight) imagesGroup:images];
    cycleScrollView.delegate = self;
    cycleScrollView.autoScrollTimeInterval = AdInterval;
    [_scrollerView addSubview:cycleScrollView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, AdViewHeight, ScreenWidth, ScreenHeight - AdViewHeight);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
}




#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    //todo
    NSLog(@"---点击了第%ld张图片", index);
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:172];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsCell identify]];
    NewsModel *model = [NewsModel getModel];
    [cell setData:model];
    return cell;
}


-(void)uploadNew
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
//    CURRENT = 0;
//    [self requestList : NO];
}

-(void)uploadMore
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
//    CURRENT += REQUEST_SIZE;
//    [self requestList : YES];
}

@end
