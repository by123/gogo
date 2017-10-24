//
//  SchedulePage.m
//  gogo
//
//  Created by by.huang on 2017/10/24.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ScheduleView.h"
#import "NewsCell.h"
#import "ScheduleTitleCell.h"
#import "ScheduleContentCell.h"
#import "ScheduleModel.h"

@interface ScheduleView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIScrollView *scrollerView;

@end

@implementation ScheduleView


-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, 500);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, [PUtil getActualHeight:110] * 15 );
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self addSubview:_scrollerView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, 3000);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:110];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *models = [ScheduleModel getModel];
    ScheduleModel *model = [models objectAtIndex:indexPath.row];
    if(model.type == Title){
        ScheduleTitleCell *cell =  [tableView dequeueReusableCellWithIdentifier:[ScheduleTitleCell identify]];
        if(cell == nil){
            cell = [[ScheduleTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleTitleCell identify]];
        }
        [cell setData:model.title];
        return cell;
    }else{
        ScheduleContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[ScheduleContentCell identify]];
        if(cell == nil){
            cell = [[ScheduleContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleContentCell identify]];
        }
        [cell setData:model.contentModel];
        return cell;
    }
}



@end
