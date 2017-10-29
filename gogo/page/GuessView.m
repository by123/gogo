//
//  GuessView.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessView.h"
#import "GuessListModel.h"
#import "TouchTableView.h"
#import "TouchScrollView.h"
#import "GuessCell.h"

@interface GuessView()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) TouchTableView *tableView;
@property (strong, nonatomic) TouchScrollView *scrollerView;
@property (strong, nonatomic) UIButton *liveBtn;

@end

@implementation GuessView{
    NSMutableArray *models;
}

-(instancetype)init{
    if(self == [super init]){
        models = [GuessListModel models];
        [self initView];
    }
    return self;
}

-(void)initView{
    int height = 0;
    for(GuessListModel *guessListModel in models){
        NSMutableArray *datas = guessListModel.models;
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
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self addSubview:_scrollerView];
    
    _tableView = [[TouchTableView alloc]initWithParentView:_scrollerView];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, height);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = c06_backgroud;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
    
    _liveBtn = [[UIButton alloc]init];
    _liveBtn.frame = CGRectMake([PUtil getActualWidth:540], [PUtil getActualHeight:683],[PUtil getActualWidth:170] , [PUtil getActualHeight:72]);
    [_liveBtn setTitle:@"看直播" forState:UIControlStateNormal];
    _liveBtn.layer.masksToBounds = YES;
    _liveBtn.layer.cornerRadius = [PUtil getActualHeight:72]/2;
    [_liveBtn addTarget:self action:@selector(goLivePage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_liveBtn];
    [ColorUtil setGradientColor:_liveBtn startColor:c01_blue endColor:c02_red director:Left];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [models count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GuessListModel *guessListModel = [models objectAtIndex:indexPath.row];
    NSMutableArray *datas = guessListModel.models;
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
    GuessListModel *model = [models objectAtIndex:indexPath.row];
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

-(void)goLivePage{
    if(_delegate){
        [_delegate goLivePage];
    }
}

@end
