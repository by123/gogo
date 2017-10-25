//
//  ScheduleModel.m
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ScheduleModel.h"
#import "ContentModel.h"

@implementation ScheduleModel

+(NSMutableArray *)getModel{
    NSMutableArray *resultModel = [[NSMutableArray alloc]init];
    ScheduleModel *s1 = [[ScheduleModel alloc]init];
    s1.title = @"10月20日";
    s1.type = Title;
    [resultModel addObject:s1];
    
    ScheduleModel *s2 = [[ScheduleModel alloc]init];
    ContentModel *m1 = [[ContentModel alloc]init];
    m1.time = @"19:30";
    m1.a = @"XQ";
    m1.b = @"GK";
    m1.needLine = YES;
    s2.type = Content;
    s2.contentModel = m1;
    [resultModel addObject:s2];
    
    ScheduleModel *s3 = [[ScheduleModel alloc]init];
    ContentModel *m2 = [[ContentModel alloc]init];
    m2.time = @"21:30";
    m2.a = @"AS仙阁";
    m2.b = @"AG超会玩";
    m2.needLine = NO;
    s3.type = Content;
    s3.contentModel = m2;
    [resultModel addObject:s3];

    return resultModel;
}

@end
