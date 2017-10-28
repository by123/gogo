//
//  ExchangePage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ExchangePage.h"
#import "BarView.h"
#import "ExchangeModel.h"
#import "ExchangeCell.h"

@interface ExchangePage ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) BarView *barView;
@property(strong, nonatomic) UIScrollView *scrollerView;
@property(strong, nonatomic) UITableView *tableView;

@end

@implementation ExchangePage{
    NSMutableArray *models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    models = [ExchangeModel getModels];
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
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, [models count] * [PUtil getActualHeight:168]);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self.view addSubview:_scrollerView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,  0, ScreenWidth, [models count] * [PUtil getActualHeight:168]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    _tableView.userInteractionEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [models count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:168];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExchangeCell *cell =  [tableView dequeueReusableCellWithIdentifier:[ExchangeCell identify]];
    if(cell == nil){
        cell = [[ExchangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ExchangeCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == [models count]-1){
        [cell setData:[models objectAtIndex:indexPath.row] hideline:YES];
    }else{
        [cell setData:[models objectAtIndex:indexPath.row] hideline:NO];
    }
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
