
//
//  ScheduleDetailPage.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ScheduleDetailPage.h"
#import "BarView.h"
#import "BySegmentView.h"
#import "BriefIntroduceView.h"
@interface ScheduleDetailPage ()

@property (strong, nonatomic) BarView *barView;

@end

@implementation ScheduleDetailPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    
    _barView = [[BarView alloc]initWithTitle:@"赛事详情" page:self];
    [self.view addSubview:_barView];
    
    NSMutableArray *views = [[NSMutableArray alloc]init];
    BriefIntroduceView *briefIntroduceView = [[BriefIntroduceView alloc]init];
    for(int i= 0 ;i <4 ;i++){
        [views addObject:briefIntroduceView];
    }
    
    BySegmentView *segmentView = [[BySegmentView alloc]initWithFrame:CGRectMake(0, StatuBarHeight + _barView.mj_h, ScreenWidth, ScreenHeight - (StatuBarHeight + _barView.mj_h)) andTitleArray:@[@"比赛简介", @"队伍详情",@"历史交战",@"评论(251)"] andShowControllerNameArray:views];
    [self.view addSubview:segmentView];
    
    
}



@end
