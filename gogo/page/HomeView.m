//
//  OnePage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "HomeView.h"
#import "NewsCell.h"
#import "RespondModel.h"


#define AdViewHeight [PUtil getActualHeight:300]
#define AdInterval 3.0f

@interface HomeView ()

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation HomeView{
    long index;
    long size;
    NSMutableArray *datas;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        datas = [[NSMutableArray alloc]init];
        [self initView];
    }
    return self;
}


-(void)initView{
   
    _scrollerView = [[UIScrollView alloc]init];
    _scrollerView.frame = CGRectMake(0, 0, ScreenWidth, self.frame.size.height);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth, [PUtil getActualHeight:172] * 10 + AdViewHeight);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self addSubview:_scrollerView];
    
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
    _tableView.frame = CGRectMake(0, AdViewHeight, ScreenWidth, [PUtil getActualHeight:172] * 10);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
    
    [self requestNew];
}




#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if(_handleDelegate){
        [_handleDelegate goNewsDetailPage:1L];
    }
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:172];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_handleDelegate){
        [_handleDelegate goNewsDetailPage:1L];
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NewsCell identify]];
    if(cell == nil){
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell setData:[datas objectAtIndex:indexPath.row]];
    return cell;
}


-(void)requestNew
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    [self requestList : NO];
}

-(void)requestMore
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    [self requestList : YES];
}

-(void)requestList : (Boolean) isRequestMore{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%ld",index] forKey:@"index"];
    [dic setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"size"];
    [ByNetUtil get:API_NEWS_LIST parameters:dic success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id items = [respondModel.data objectForKey:@"items"];
            index =(long)[respondModel.data objectForKey:@"index"];
            datas = [NewsModel mj_objectArrayWithKeyValuesArray:items];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"获取列表失败！"];
    }];
    
}

@end
