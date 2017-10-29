//
//  NewsDetailPage.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "NewsDetailPage.h"
#import "BarView.h"
#import "TitleView.h"
#import "InsetTextField.h"
#import "CommentModel.h"
#import "CommentCell.h"
#import "TouchScrollView.h"

#define CommentCellHeight [PUtil getActualHeight:180]
@interface NewsDetailPage ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) BarView *barView;
@property (strong, nonatomic) UIView *imageView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) TitleView *commentTitleView;
@property (strong, nonatomic) TouchScrollView *scrollerView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *commentView;
@property (strong, nonatomic) InsetTextField *commentTextField;
@property (strong, nonatomic) UILabel *hintLabel;

@end

@implementation NewsDetailPage{
    NSMutableArray *models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)initView{
    models = [CommentModel getModels];
    _barView = [[BarView alloc]initWithTitle:@"标题" page:self];
    [self.view addSubview:_barView];
    
    _scrollerView = [[TouchScrollView alloc]initWithParentView:self.view];
    _scrollerView.frame = CGRectMake(0, StatuBarHeight + _barView.mj_h, ScreenWidth, ScreenHeight - (StatuBarHeight + _barView.mj_h)-[PUtil getActualHeight:110]);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(uploadMore)];
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth,CommentCellHeight* [models count]+ [PUtil getActualHeight:781-88] - StatuBarHeight);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(uploadNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self.view addSubview:_scrollerView];
    
    _imageView = [[UIView alloc]init];
    _imageView.backgroundColor = c01_blue;
    _imageView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualWidth:30], ScreenWidth - [PUtil getActualWidth:30]*2, [PUtil getActualHeight:345]);
    [_scrollerView addSubview:_imageView];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = c08_text;
    _contentLabel.text = @"文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字文字";
    _contentLabel.numberOfLines = 0;
    _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _contentLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    _contentLabel.frame = CGRectMake([PUtil getActualWidth:30], _imageView.mj_h+_imageView.mj_y + [PUtil getActualHeight:16], ScreenWidth - [PUtil getActualWidth:30]*2, [PUtil getActualHeight:144]);
    [_scrollerView addSubview:_contentLabel];
    
    int height = _contentLabel.mj_h + _contentLabel.mj_y + [PUtil getActualWidth:30];
    _commentTitleView = [[TitleView alloc]initWithTitle:height title:@"评论（12）"];
    [_scrollerView addSubview:_commentTitleView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, _commentTitleView.mj_y+_commentTitleView.mj_h, ScreenWidth,  CommentCellHeight* [models count]);
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = c06_backgroud;
    _tableView.scrollEnabled = NO;
    _tableView.userInteractionEnabled = NO;
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_scrollerView addSubview:_tableView];
    
    _commentView  = [[UIView alloc]init];
    _commentView.backgroundColor = c07_bar;
    _commentView.frame = CGRectMake(0, ScreenHeight - [PUtil getActualHeight:110], ScreenWidth, [PUtil getActualHeight:110]);
    [self.view addSubview:_commentView];
    
    _commentTextField = [[InsetTextField alloc]initWithFrame: CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:15], ScreenWidth -[PUtil getActualWidth:30]*2 , [PUtil getActualHeight:80]) andInsets:UIEdgeInsetsMake(0, [PUtil getActualWidth:16], 0, [PUtil getActualWidth:16])];
    _commentTextField.backgroundColor = c06_backgroud;
    _commentTextField.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    _commentTextField.textColor = c08_text;
    _commentTextField.returnKeyType = UIReturnKeySend;
    _commentTextField.layer.masksToBounds = YES;
    _commentTextField.layer.cornerRadius = [PUtil getActualHeight:10];
    _commentTextField.delegate = self;
    [_commentView addSubview:_commentTextField];
    
    _hintLabel = [[UILabel alloc]init];
    _hintLabel.text = @"发表评论";
    _hintLabel.textColor = c08_text;
    _hintLabel.alpha = 0.5f;
    _hintLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    _hintLabel.frame =  CGRectMake([PUtil getActualWidth:46], [PUtil getActualHeight:32], [PUtil getActualHeight:140] , [PUtil getActualHeight:46]);
    [_commentView addSubview:_hintLabel];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [models count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CommentCellHeight;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:[CommentCell identify]];
    if(cell == nil){
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[CommentCell identify]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CommentModel *model = [models objectAtIndex:indexPath.row];
    [cell setData:model];
    return cell;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    _hintLabel.hidden = YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField.text isEqualToString:@""]){
        _hintLabel.hidden = NO;
    }
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    CGRect commmentViewRect = _commentView.frame;
    commmentViewRect.origin.y += yOffset;
    __weak UIView *commentView = _commentView;
    [UIView animateWithDuration:duration animations:^{
        commentView.frame = commmentViewRect;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_commentTextField resignFirstResponder];
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

@end
