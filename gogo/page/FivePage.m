//
//  FivePage.m
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "FivePage.h"

@interface FivePage ()

@property (strong, nonatomic ) UILabel *contentLabel;

@end

@implementation FivePage

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight)];
    _contentLabel.text = @"战队";
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.font = [UIFont systemFontOfSize:30.0f];
    [self.view addSubview:_contentLabel];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CombatTeams" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    
    for(NSMutableDictionary *dic in data)
    {
        NSString *combatName = [dic objectForKey:@"name"];
        NSMutableArray  *array = [dic mutableArrayValueForKey:@"members"];
        for(NSMutableDictionary *dic2 in array)
        {
            NSString *name = [dic2 objectForKey:@"name"];
            NSString *position = [dic2 objectForKey:@"position"];
            NSString *goodat = [dic2 objectForKey:@"goodat"];
            
            NSString *result = [NSString stringWithFormat:@"战队：%@  队员：%@  位置：%@  擅长：%@",combatName,name,position,goodat];
            NSLog(@"%@",result);
        }
        
    }
}

@end
