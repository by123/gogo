//
//  CropsModel.m
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "CorpsModel.h"

@implementation CorpsModel

+(NSMutableArray *)getModels{
    NSArray *datas = @[@"AG超会玩",@"AS仙阁",@"EDG.M",@"eStar",@"GK"];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(NSString *data in datas){
        CorpsModel *model = [[CorpsModel alloc]init];
        model.corpsName = data;
        [array addObject:model];
    }
    return array;
}
@end
