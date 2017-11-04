//
//  MinePage.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MineView.h"
#import "MineCell.h"
#import "LoginPage.h"
#import "TouchScrollView.h"
#import "AccountManager.h"

@interface MineView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) TouchScrollView *scrollerView;
@property (strong, nonatomic) UIView *userView;
@property (strong, nonatomic) UIImageView *headImageView;
@property (strong, nonatomic) UILabel *nickNameLabel;
@property (strong, nonatomic) UILabel *coinLabel;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIButton *logoutBtn;

@end

@implementation MineView{
    NSArray *datas;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        datas = @[@"充值",@"地址信息",@"竞猜历史",@"兑换记录",@"关于"];
        [self initView];
    }
    return self;
}


-(void)initView{
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *nickName = [userDefaults  objectForKey:@"nickname"];
    NSString *headimgurl = [userDefaults objectForKey:@"headimgurl"];
    
    _scrollerView = [[TouchScrollView alloc]initWithParentView:self];
    _scrollerView.frame = self.frame;
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.contentSize = CGSizeMake(ScreenWidth,ScreenHeight);
    [self addSubview:_scrollerView];
    
    _userView = [[UIView alloc]init];
    _userView.frame = CGRectMake(0, [PUtil getActualHeight:20], ScreenWidth, [PUtil getActualHeight:272]);
    _userView.backgroundColor = c07_bar;
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goPersonalPage)];
    [_userView addGestureRecognizer:recognizer];
    [_scrollerView addSubview:_userView];
    
    _headImageView = [[UIImageView alloc]init];
    _headImageView.frame = CGRectMake([PUtil getActualWidth:40], [PUtil getActualHeight:56], [PUtil getActualWidth:160], [PUtil getActualWidth:160]);
    _headImageView.backgroundColor = c01_blue;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:headimgurl]];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = [PUtil getActualWidth:160]/2;
    [_userView addSubview:_headImageView];
    
    _nickNameLabel = [[UILabel alloc]init];
    _nickNameLabel.text = nickName;
    _nickNameLabel.textColor = c08_text;
    _nickNameLabel.frame = CGRectMake([PUtil getActualWidth:240], [PUtil getActualHeight:55], ScreenWidth - [PUtil getActualWidth:240], [PUtil getActualHeight:67]);
    _nickNameLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:48]];
    [_userView addSubview:_nickNameLabel];
    
    UILabel *coinTitleLabel = [[UILabel alloc]init];
    coinTitleLabel.text = @"竞猜币";
    coinTitleLabel.textColor = c09_tips;
    coinTitleLabel.frame = CGRectMake([PUtil getActualWidth:240], [PUtil getActualHeight:122], ScreenWidth - [PUtil getActualWidth:240], [PUtil getActualHeight:40]);
    coinTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    [_userView addSubview:coinTitleLabel];

    _coinLabel = [[UILabel alloc]init];
    _coinLabel.text = @"1000";
    _coinLabel.textColor = c15_text3;
    _coinLabel.frame = CGRectMake([PUtil getActualWidth:240], [PUtil getActualHeight:162], ScreenWidth - [PUtil getActualWidth:240], [PUtil getActualHeight:56]);
    _coinLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:40]];
    [_userView addSubview:_coinLabel];
    
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0,  [PUtil getActualHeight:312], ScreenWidth, [datas count]*[PUtil getActualHeight:110]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
    
    _logoutBtn = [[UIButton alloc]init];
    _logoutBtn.frame = CGRectMake((ScreenWidth - [PUtil getActualWidth:542])/2, [PUtil getActualHeight:922],[PUtil getActualWidth:542] , [PUtil getActualHeight:100]);
    [_logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    _logoutBtn.layer.masksToBounds = YES;
    _logoutBtn.layer.cornerRadius = [PUtil getActualHeight:100]/2;
    [_logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    [_scrollerView addSubview:_logoutBtn];
    [ColorUtil setGradientColor:_logoutBtn startColor:c01_blue endColor:c02_red director:Left];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [PUtil getActualHeight:110];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self goPage : indexPath.row];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineCell *cell =  [tableView dequeueReusableCellWithIdentifier:[MineCell identify]];
    if(cell == nil){
        cell = [[MineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[MineCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if(indexPath.row == [datas count]-1){
        [cell setData:[datas objectAtIndex:indexPath.row] hideline:YES];
    }else{
        [cell setData:[datas objectAtIndex:indexPath.row] hideline:NO];
    }
    return cell;
}

-(void)logout{
    if(_handleDelegate){
        [[AccountManager sharedAccountManager] clear];
        [_handleDelegate goLoginPage];
    }
}

-(void)goPage : (NSInteger)index{
    if(_handleDelegate){
        switch (index) {
            case 0:
                [_handleDelegate goChargePage];
                break;
            case 1:
                [_handleDelegate goAddressPage];
                break;
            case 2:
                [_handleDelegate goHistoryPage];
                break;
            case 3:
                [_handleDelegate goExchangePage];
                break;
            case 4:
                [_handleDelegate goAboutPage];
                break;
            default:
                break;
        }
    }
}

-(void)goPersonalPage{
    if(_handleDelegate){
        [_handleDelegate goPersonalPage];
    }
}

@end
