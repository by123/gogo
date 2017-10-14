//
//  TwoPage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "TwoPage.h"

@interface TwoPage ()

@property (strong, nonatomic ) UILabel *contentLabel;

@end

@implementation TwoPage

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _contentLabel.text = @"赛程";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:30.0f];
    [self.view addSubview:_contentLabel];
}

@end
