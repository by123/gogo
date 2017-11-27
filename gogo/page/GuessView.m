//
//  GuessView.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessView.h"
#import "TouchTableView.h"
#import "TouchScrollView.h"
#import "GuessCell.h"
#import "BettingModel.h"

@interface GuessView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) TouchTableView *tableView;
@property (strong, nonatomic) TouchScrollView *scrollerView;

@end

@implementation GuessView{
    NSMutableArray *models;
    long rid;
    Boolean end;
}

-(instancetype)initWithDatas : (NSMutableArray *)datas end:(Boolean)isEnd{
    if(self == [super init]){
        models = datas;
        end = isEnd;
        [self initView];
    }
    return self;
}

-(void)initView{
    int height = 0;
    for(BettingModel *bettingModel in models){
        NSMutableArray *datas = bettingModel.items;
        NSInteger rows = [datas count] / 3;
        int per = [PUtil getActualHeight:117];
        height += [PUtil getActualHeight:206] + per * rows;
    }

    self.backgroundColor = c06_backgroud;
    _scrollerView = [[TouchScrollView alloc]initWithParentView:self];
    _scrollerView.userInteractionEnabled =YES;
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - [PUtil getActualHeight:539]);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth,  height);
//    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
//    header.lastUpdatedTimeLabel.hidden = YES;
//    _scrollerView.mj_header = header;
    [self addSubview:_scrollerView];
    
    _tableView = [[TouchTableView alloc]initWithParentView:_scrollerView];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = c06_backgroud;
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
    BettingModel *bettingModel = [models objectAtIndex:indexPath.row];
    NSMutableArray *datas = [BettingItemModel mj_objectArrayWithKeyValuesArray:bettingModel.items];
    NSInteger rows = [datas count] / 3;
    int per = [PUtil getActualHeight:117];
    return [PUtil getActualHeight:206] + per * rows;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuessCell *cell =  [tableView dequeueReusableCellWithIdentifier:[GuessCell identify]];
    if(cell == nil){
        cell = [[GuessCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[GuessCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    BettingModel *bettingModel = [models objectAtIndex:indexPath.row];
    if(end){
        bettingModel.betting_status = Statu_AlreadyBet;
    }else{
        bettingModel.betting_status = Statu_NotBet;
    }
    [cell setData:bettingModel deleaget:self];
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


-(void)onClick:(BettingItemModel *)model{
    if(_delegate){
        [_delegate OpenGuessOrderView:model guessView:self];
    }
}

-(void)restoreItems{
    for(BettingModel *bettingModel in models){
        NSMutableArray *datas = [BettingItemModel mj_objectArrayWithKeyValuesArray:bettingModel.items];
        for(BettingItemModel *itemModel in datas){
            itemModel.isSelect = NO;
        }
    }
    [_tableView reloadData];
}

@end
