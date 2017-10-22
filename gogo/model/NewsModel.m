//
//  NewsModel.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel


+(NewsModel *)getModel{
    NewsModel *model = [[NewsModel alloc]init];
    model.nid = 1;
    model.title = @"抢先服：“峡谷起源”版本公告：S9赛季开启，部分英雄技能调整！";
    model.type = @"赛事预告";
    model.imageUrl = @"http://game.gtimg.cn/images/yxzj/cp/a20170929znq/pic-map1.jpg";
    model.comments = @"888";
    return model;
}


@end
