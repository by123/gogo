//
//  SchedulePage.m
//  gogo
//
//  Created by by.huang on 2017/10/24.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "SchedulePage.h"
#import "NewsCell.h"

@interface SchedulePage ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation SchedulePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, self.view.mj_h);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:172];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell *cell =  [tableView dequeueReusableCellWithIdentifier:[NewsCell identify]];
    if(cell == nil){
        cell = [[NewsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NewsCell identify]];
    }
    NewsModel *model = [NewsModel getModel];
    [cell setData:model];
    return cell;
}



@end
