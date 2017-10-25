

//
//  CommentModel.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+(NSMutableArray *)getModels{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    CommentModel *model = [[CommentModel alloc]init];
    model.name = @"李银河";
    model.time = @"6月25日 19:22";
    model.content = @"期待新英雄";
    for(int i =0 ;i < 10 ; i ++){
        [array addObject:model];
    }
    return array;
}

@end
