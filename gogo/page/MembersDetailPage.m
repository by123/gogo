//
//  MembersDetailPage.m
//  gogo
//
//  Created by by.huang on 2017/10/27.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MembersDetailPage.h"
#import "BarView.h"
#import "MemberModel.h"
#import "MemberCell.h"

@interface MembersDetailPage ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BarView *barView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MembersDetailPage{
    NSMutableArray *models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    models = [MemberModel getModels];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"队员介绍" page:self];
    [self.view addSubview:_barView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, StatuBarHeight + [PUtil getActualHeight:88], ScreenWidth, ScreenHeight - StatuBarHeight - [PUtil getActualHeight:88]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_tableView];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [models count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:200];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberCell *cell =  [tableView dequeueReusableCellWithIdentifier:[MemberCell identify]];
    if(cell == nil){
        cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MemberCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    MemberModel *model = [models objectAtIndex:indexPath.row];
    [cell setData:model];
    return cell;
}




@end
