//
//  CorpsPage.m
//  gogo
//
//  Created by by.huang on 2017/10/24.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "CorpsView.h"
#import "CorpsModel.h"
#import "CorpsCell.h"
#import "RespondModel.h"

@interface CorpsView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIScrollView *scrollerView;

@end

@implementation CorpsView{
    NSMutableArray *models;
}

- (instancetype)init {
    if(self == [super init]){
        [self initView];
        [self requestList];
    }
    return self;
}

-(void)initView{
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - [PUtil getActualHeight:316]);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, ScreenHeight);
    [self addSubview:_scrollerView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = _scrollerView.frame;
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
    return [PUtil getActualHeight:110];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_handleDelegate){
        [_handleDelegate goCorpsDetailPage:1L];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CorpsCell *cell =  [tableView dequeueReusableCellWithIdentifier:[CorpsCell identify]];
    if(cell == nil){
        cell = [[CorpsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CorpsCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CorpsModel *model = [models objectAtIndex:indexPath.row];
    [cell setData:model];
    return cell;
}

-(void)requestList{
    [ByNetUtil get:API_TEAMLIST parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            id items = [data objectForKey:@"items"];
            models = [CorpsModel mj_objectArrayWithKeyValuesArray:items];
            [_tableView reloadData];
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
        _tableView.frame = CGRectMake(0, 0, ScreenWidth, [models count] * [PUtil getActualHeight:110]);
        _scrollerView.contentSize = CGSizeMake(ScreenWidth, [models count] * [PUtil getActualHeight:110]);
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"请求失败"];
    }];
}



@end
