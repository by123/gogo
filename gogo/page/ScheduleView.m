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
#import "RespondModel.h"
#import "TimeUtil.h"
@interface ScheduleView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIScrollView *scrollerView;

@end

@implementation ScheduleView{
    int index;
    NSMutableArray *datas;
    NSMutableArray *titles;
}


-(instancetype)init{
    if(self == [super init]){
        index = 0;
        titles = [[NSMutableArray alloc]init];
        [self initView];
        [self requestList:NO];
    }
    return self;
}

-(void)initView{
    int height = 0;
    for(ScheduleModel *model in datas){
        if(model.type == Title){
            height +=[PUtil getActualHeight:86];
        }else{
            height +=[PUtil getActualHeight:164];
        }
    }
    
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatuBarHeight - [PUtil getActualHeight:188]);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, height * 5);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self addSubview:_scrollerView];
    

    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, height*5);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [titles count];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *models = [datas objectAtIndex:indexPath.row];
    ScheduleModel *model = [models objectAtIndex:indexPath.row];
    if(model.type == Title){
        return [PUtil getActualHeight:86];
    }
    return [PUtil getActualHeight:164];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_handleDelegate){
        [_handleDelegate goScheduleDetailPage:1L];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleModel *model = [datas objectAtIndex:indexPath.row];
    if(model.type == Title){
        ScheduleTitleCell *cell =  [tableView dequeueReusableCellWithIdentifier:[ScheduleTitleCell identify]];
        if(cell == nil){
            cell = [[ScheduleTitleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleTitleCell identify]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        [cell setData: [titles objectAtIndex:indexPath.row]];
        return cell;
    }else{
        ScheduleContentCell *cell =  [tableView dequeueReusableCellWithIdentifier:[ScheduleContentCell identify]];
//        if(cell == nil){
//            cell = [[ScheduleContentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleContentCell identify]];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            [cell setDelegate:_handleDelegate];
//        }
//        [cell setData:model.contentModel];
        return cell;
    }
}

-(void)uploadNew
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    index = 0;
    [self requestList : NO];
}

-(void)uploadMore
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    [self requestList : YES];

}


-(void)requestList : (Boolean)isReuqestMore{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"index"] = @(index);
    dic[@"size"] = @(1000);

    [ByNetUtil get:API_RACE parameters:dic success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            index = [[data objectForKey:@"index"] intValue];
            id items = [data objectForKey:@"items"];
            datas = [ScheduleModel mj_objectArrayWithKeyValuesArray:items];
            [self handleDatas];
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"请求失败"];

    }];
}


-(void)handleDatas{
    for(ScheduleModel *model in datas){
       NSString *date =  [TimeUtil generateData:model.race_ts];
        Boolean hasDate = NO;
//        for(NSString *dateStr in titles){
//            if([dateStr isEqualToString:date]){
//                hasDate = YES;
//            }
//        }
//        if(!hasDate){
            [titles addObject:date];
//        }
    }
    NSLog(@"");
}


@end
