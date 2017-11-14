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
#import "CommentCell.h"
#import "TouchScrollView.h"
#import "RespondModel.h"
#import "NewsDetailModel.h"
#import "CommentListModel.h"
#import "RHPlayerView.h"
#import "RHVideoModel.h"

#define CommentCellHeight [PUtil getActualHeight:180]
#define REREQUESTSIZE 10
@interface NewsDetailPage ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIWebViewDelegate,RHPlayerViewDelegate,BarViewDelegate>

@property (strong, nonatomic) BarView *barView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) TitleView *commentTitleView;
@property (strong, nonatomic) TouchScrollView *scrollerView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *commentView;
@property (strong, nonatomic) InsetTextField *commentTextField;
@property (strong, nonatomic) UILabel *hintLabel;
@property (strong, nonatomic) UIScrollView *webScrollView;
@property (strong, nonatomic) RHPlayerView *playView;

@end

@implementation NewsDetailPage{
    NewsDetailModel *model;
    int index;
    NSMutableArray *datas;
    Boolean webLoadFinish;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    datas = [[NSMutableArray alloc]init];
    index = 0;
    [self requestData : NO];
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    if(_playView){
        [_playView stop];
        NSLog(@"by666暂停了");
    }
}


-(void)initView{
    _barView = [[BarView alloc]initWithTitle:model.title page:self delegate:self];
    [self.view addSubview:_barView];
    
    _scrollerView = [[TouchScrollView alloc]initWithParentView:self.view];
    _scrollerView.backgroundColor = c06_backgroud;
    _scrollerView.frame = CGRectMake(0, StatuBarHeight + _barView.mj_h, ScreenWidth, ScreenHeight - [PUtil getActualHeight:238]);
    _scrollerView.showsVerticalScrollIndicator = NO;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
    _scrollerView.scrollEnabled = NO;
    
    _scrollerView.contentSize = CGSizeMake(ScreenWidth,ScreenHeight);
    MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
    header.lastUpdatedTimeLabel.hidden = YES;
    _scrollerView.mj_header = header;
    [self.view addSubview:_scrollerView];
    
    if(IS_NS_STRING_EMPTY(model.video)){
        _webView = [[UIWebView alloc]init];
        _webView.frame = CGRectMake(0,0, ScreenWidth,ScreenHeight);
        _webView.allowsInlineMediaPlayback = YES;
        _webView.scalesPageToFit = YES;
        _webView.opaque = NO;
        _webView.delegate = self;
        _webScrollView = (UIScrollView *)[_webView.subviews objectAtIndex:0];
        _webScrollView.scrollEnabled = NO;
        NSString *htmlStr = [NSString stringWithFormat:@"<head></head><body style=\"zoom:1.5\">%@</body>",model.body];
        [_webView loadHTMLString:htmlStr baseURL:nil];
        [_scrollerView addSubview:_webView];
    }else{
        _playView = [[RHPlayerView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * ScreenWidth / ScreenHeight) currentVC:self parentView : _scrollerView];
        _playView.delegate = self;
        NSMutableArray *dataArr = [[NSMutableArray alloc]init];
        RHVideoModel *videoModel = [[RHVideoModel alloc] initWithVideoId:@"" title:@"" url:model.video currentTime:0];
        [dataArr addObject:videoModel];
        [_playView setVideoModels:dataArr playVideoId:@""];
        [_scrollerView addSubview:_playView];
        [self initComment];
        [self requestNew];
    }
    
    
}

-(void)initComment{
    int height = 0;
    if(IS_NS_STRING_EMPTY(model.video)){
        height = _webView.mj_h + _webView.mj_y;
    }else{
        height = ScreenWidth * ScreenWidth /ScreenHeight;
    }
    
    _commentTitleView = [[TitleView alloc]initWithTitle:height title:@"评论（0）"];
    [_commentTitleView setTitle:[NSString stringWithFormat:@"评论（%d）",model.comment_count]];
    [_scrollerView addSubview:_commentTitleView];
    
    _tableView = [[UITableView alloc]init];
    _tableView.frame = CGRectMake(0, _commentTitleView.mj_y+_commentTitleView.mj_h, ScreenWidth,  ScreenHeight);
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
    
    _scrollerView.scrollEnabled = YES;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [datas count];
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
    CommentListModel *model = [datas objectAtIndex:indexPath.row];
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(!IS_NS_STRING_EMPTY(textField.text)){
        [self addComment];
    }
    return YES;
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


-(void)requestNew
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    index = 0;
    [self requestComment : NO];
}

-(void)requestMore
{
    [_scrollerView.mj_header endRefreshing];
    [_scrollerView.mj_footer endRefreshing];
    [self requestComment : YES];
}

-(void)requestData : (Boolean)updateComment{
    NSString *urlStr = [NSString stringWithFormat:@"%@%ld",API_NEWS_DETAIL,_news_id];
    [ByNetUtil get:urlStr parameters:nil success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            model = [NewsDetailModel mj_objectWithKeyValues:data];
            if(updateComment){
                [_commentTitleView setTitle:[NSString stringWithFormat:@"评论（%d）",model.comment_count]];
            }else{
                [self initView];
            }
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
    } failure:^(NSError *error) {
        
    }];
}



- (void)webViewDidFinishLoad:(UIWebView*)webView{
    if(_webView.isLoading){
        return;
    }
    CGFloat WebViewHeight = [webView.scrollView contentSize].height;
    CGRect WebViewRect = webView.frame;
    WebViewRect.size.height = WebViewHeight;
    _scrollerView.contentSize = CGSizeMake(ScreenWidth,CommentCellHeight* [datas count]+ [PUtil getActualHeight:88] +WebViewHeight);
    _webView.frame = WebViewRect;
    _webScrollView.contentSize = CGSizeMake(ScreenWidth, WebViewHeight);
    
    [self initComment];
    [self requestNew];
}

-(void)requestComment : (Boolean) isRequestMore{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"index"] = @(index);
    dic[@"size"] = @(REREQUESTSIZE);
    dic[@"target_id"] = [NSString stringWithFormat:@"%ld",_news_id];
    dic[@"tp"] = @"news";
    [ByNetUtil get:API_COMMENT parameters:dic success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            id data = respondModel.data;
            id items = [data objectForKey:@"items"];
            index = [[data objectForKey:@"index"] intValue];
            if(isRequestMore){
                NSArray *temps = [CommentListModel mj_objectArrayWithKeyValuesArray:items];
                if([temps count] == 0){
                    [_scrollerView.mj_footer endRefreshingWithNoMoreData];
                }
                [datas addObjectsFromArray:temps];
            }else{
                datas = [CommentListModel mj_objectArrayWithKeyValuesArray:items];
            }
            _tableView.frame = CGRectMake(0, _commentTitleView.mj_y+_commentTitleView.mj_h, ScreenWidth, [datas count] *CommentCellHeight);
            _scrollerView.contentSize = CGSizeMake(ScreenWidth, CommentCellHeight* [datas count]+_webView.mj_h +[PUtil getActualHeight:88]);
            [_tableView reloadData];
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
    } failure:^(NSError *error) {
        
    }];
}


-(void)addComment{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    dic[@"content"] = _commentTextField.text;
    dic[@"tp"] = @"news";
    dic[@"target_id"] = [NSString stringWithFormat:@"%ld",_news_id];
    [ByNetUtil post:API_ADDCOMMENT parameters:dic success:^(RespondModel *respondModel) {
        if(respondModel.code == 200){
            [DialogHelper showSuccessTips:@"发送成功!"];
            [self requestNew];
            [self requestData : YES];
        }else{
            [DialogHelper showFailureAlertSheet:respondModel.msg];
        }
    } failure:^(NSError *error) {
        [DialogHelper showFailureAlertSheet:@"评论失败"];
    }];

}


-(BOOL)playerViewShouldPlay{
    return YES;
}

// 当前播放的
- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
    
    
}
// 当前播放结束的
- (void)playerView:(RHPlayerView *)playView didPlayEndVideo:(RHVideoModel *)videoModel index:(NSInteger)index {
    
    
}
// 当前正在播放的  会调用多次  更新当前播放时间
- (void)playerView:(RHPlayerView *)playView didPlayVideo:(RHVideoModel *)videoModel playTime:(NSTimeInterval)playTime {
    
    
}

-(void)onBackClick{
    if(_playView){
        [_playView removePlayer];
        _playView = nil;
        [self.navigationController popViewControllerAnimated:YES];
        NSLog(@"by666移除了");
    }
}

@end
