//
//  ChargePage.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ChargePage.h"
#import "BarView.h"
#import "PriceCell.h"
#import "PayCell.h"

@interface ChargePage ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BarView *barView;
@property (strong, nonatomic) UITableView *priceTableView;
@property (strong, nonatomic) UITableView *payTableView;
@property (strong, nonatomic) UIButton *payBtn;

@end

@implementation ChargePage{
    NSArray *priceArray;
    NSArray *payArray;
    NSInteger priceSelect;
    NSInteger paySelect;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    priceArray = @[@"6元600竞猜币",@"30元400竞猜币",@"68元1000竞猜币",@"128元30000竞猜币"];
    payArray = @[@"微信支付",@"支付宝支付"];
    [self initView];
}

-(void)initView{
    _barView = [[BarView alloc]initWithTitle:@"充值" page:self];
    [self.view addSubview:_barView];
    
    int height = _barView.mj_h+_barView.mj_y;
    UILabel *priceTitle = [[UILabel alloc]init];
    priceTitle.text = @"请选择充值的数量";
    priceTitle.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    priceTitle.textColor = c09_tips;
    priceTitle.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:30] + height, ScreenWidth - [PUtil getActualWidth:30], [PUtil getActualHeight:40]);
    [self.view addSubview:priceTitle];
    
    _priceTableView = [[UITableView alloc]init];
    _priceTableView.frame = CGRectMake(0,  [PUtil getActualHeight:86] + height, ScreenWidth, [priceArray count]*[PUtil getActualHeight:110]);
    _priceTableView.delegate = self;
    _priceTableView.dataSource = self;
    _priceTableView.scrollEnabled = NO;
    [_priceTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_priceTableView];
    
    UILabel *payTitle = [[UILabel alloc]init];
    payTitle.text = @"请选择支付方式";
    payTitle.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    payTitle.textColor = c09_tips;
    payTitle.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:556] + height, ScreenWidth - [PUtil getActualWidth:30], [PUtil getActualHeight:40]);
    [self.view addSubview:payTitle];
    
    _payTableView = [[UITableView alloc]init];
    _payTableView.frame = CGRectMake(0,  [PUtil getActualHeight:612] + height, ScreenWidth, [payArray count]*[PUtil getActualHeight:110]);
    _payTableView.delegate = self;
    _payTableView.dataSource = self;
    _payTableView.scrollEnabled = NO;
    [_payTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:_payTableView];
    
    _payBtn = [[UIButton alloc]init];
    _payBtn.frame = CGRectMake((ScreenWidth - [PUtil getActualWidth:542])/2, [PUtil getActualHeight:892] + height,[PUtil getActualWidth:542] , [PUtil getActualHeight:100]);
    [_payBtn setTitle:@"支付" forState:UIControlStateNormal];
    _payBtn.layer.masksToBounds = YES;
    _payBtn.layer.cornerRadius = [PUtil getActualHeight:100]/2;
    [_payBtn addTarget:self action:@selector(doPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_payBtn];
    [ColorUtil setGradientColor:_payBtn startColor:c01_blue endColor:c02_red director:Left];
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _priceTableView){
        return [priceArray count];
    }else{
        return [payArray count];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:110];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _priceTableView){
        priceSelect = indexPath.row;
    }else{
        paySelect = indexPath.row;
    }
    [tableView reloadData];

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == _priceTableView){
        PriceCell *cell =  [tableView dequeueReusableCellWithIdentifier:[PriceCell identify]];
        if(cell == nil){
            cell = [[PriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PriceCell identify]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.row == [priceArray count]-1){
            [cell setData:[priceArray objectAtIndex:indexPath.row] hideline:YES];
        }else{
            [cell setData:[priceArray objectAtIndex:indexPath.row] hideline:NO];
        }
        if(priceSelect == indexPath.row){
            [cell setSelect:YES];
        }else{
            [cell setSelect:NO];
        }
        return cell;
    }else{
        PayCell *cell =  [tableView dequeueReusableCellWithIdentifier:[PayCell identify]];
        if(cell == nil){
            cell = [[PayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[PayCell identify]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if(indexPath.row == [payArray count]-1){
            [cell setData:[payArray objectAtIndex:indexPath.row] hideline:YES];
        }else{
            [cell setData:[payArray objectAtIndex:indexPath.row] hideline:NO];
        }
        if(paySelect == indexPath.row){
            [cell setSelect:YES];
        }else{
            [cell setSelect:NO];
        }
        return cell;
    }
}

-(void)doPay{
    //todo
}

@end