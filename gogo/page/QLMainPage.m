//
//  QLMainPage.m
//  gogo
//
//  Created by by.huang on 2017/9/11.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "QLMainPage.h"
#import "BySegmentView.h"
#import "ByNetUtil.h"

@interface QLMainPage()<BySegmentViewDelegate>

@end

@implementation QLMainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    
    [self test];
}


-(void)initView{
    
    NSArray * titleArr = @[@"首页",@"赛程",@"直播",@"视频",@"战队"];
    
    NSArray * controllerNameArray = @[@"HomePage",@"TwoPage",@"ThreePage",@"FourPage",@"FivePage"];
    
    CGRect rect =  CGRectMake(0, 20, ScreenWidth, ScreenHeight);
    BySegmentView * segmentView = [[BySegmentView alloc]initWithFrame:rect andHeaderHeight:NavigationBarHeight andTitleArray:titleArr andShowControllerNameArray:controllerNameArray];
    segmentView.delegate = self;
    [self.view addSubview:segmentView];
    
}


-(void)didSelectIndex:(NSInteger)index{
    
}




-(void)test{

    [ByNetUtil download:@"http://example.com/download.zip" callback:^(id respondObj) {
        
    }];
}






@end
