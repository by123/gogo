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

@interface CorpsView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation CorpsView{
    NSMutableArray *models;
}

- (instancetype)init {
    if(self == [super init]){
        models = [CorpsModel getModels];
        [self initView];
    }
    return self;
}

-(void)initView{
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - StatuBarHeight - [PUtil getActualHeight:188]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self addSubview:_tableView];
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CorpsCell *cell =  [tableView dequeueReusableCellWithIdentifier:[CorpsCell identify]];
    if(cell == nil){
        cell = [[CorpsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CorpsCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CorpsModel *model = [models objectAtIndex:indexPath.row];
    [cell setData:model.corpsName];
    return cell;
}



@end
