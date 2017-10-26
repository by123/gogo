//
//  MemberModel.m
//  gogo
//
//  Created by by.huang on 2017/10/27.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

+(NSMutableArray *)getModels{
    NSMutableArray *models = [[NSMutableArray alloc]init];
    MemberModel *model = [[MemberModel alloc]init];
    model.name = @"队员姓名";
    model.introduce = @"队员介绍队员介绍队员介绍队员介绍队员介绍队员介绍队员介绍队员介绍队员介绍队员";
    for(int i=0;i<5;i++){
        [models addObject:model];
    }
    return models;
}
@end
