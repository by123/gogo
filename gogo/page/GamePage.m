//
//  GamePage.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GamePage.h"
#import "BySegmentView.h"
#import "ScheduleView.h"
#import "CorpsView.h"

@interface GamePage ()

@end

@implementation GamePage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    [self initTab];
}

-(void)initTab{
    NSMutableArray *views = [[NSMutableArray alloc]init];
    ScheduleView *scheduleView = [[ScheduleView alloc]init];
    scheduleView.handleDelegate = _handleDelegate;
    
    CorpsView *corpsView = [[CorpsView alloc]init];
    corpsView.handleDelegate = _handleDelegate;
    
    [views addObject:scheduleView];
    [views addObject:corpsView];

    BySegmentView *segmentView = [[BySegmentView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - (StatuBarHeight + [PUtil getActualHeight:188])) andTitleArray:@[@"赛事安排", @"战队介绍"] andShowControllerNameArray:views];
    [self.view addSubview:segmentView];
}




@end
