//
//  FourPage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "FourPage.h"

@interface FourPage ()

@property (strong, nonatomic ) UILabel *contentLabel;

@end

@implementation FourPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _contentLabel.text = @"视频";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:30.0f];
    [self.view addSubview:_contentLabel];
}


@end
