//
//  HistoryPage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessHistoryPage.h"
#import "BarView.h"
#import "GuessHistoryModel.h"
#import "GuessHistoryCell.h"

@interface GuessHistoryPage ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) BarView *barView;
@property(strong, nonatomic) UIScrollView *scrollerView;
@property(strong, nonatomic) UITableView *tableView;

@end

@implementation GuessHistoryPage{
    NSMutableArray *models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    models = [GuessHistoryModel getModels];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"兑换记录" page:self];
    [self.view addSubview:_barView];
    
    int height = _barView.mj_h + _barView.mj_y;
    
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, height, ScreenWidth, ScreenHeight - height);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, [models count] * [PUtil getActualHeight:580]);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self.view addSubview:_scrollerView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,  0, ScreenWidth, [models count] * [PUtil getActualHeight:580]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.userInteractionEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_scrollerView addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [models count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:580];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuessHistoryCell *cell =  [tableView dequeueReusableCellWithIdentifier:[GuessHistoryCell identify]];
    if(cell == nil){
        cell = [[GuessHistoryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GuessHistoryCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:[models objectAtIndex:indexPath.row]];
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

