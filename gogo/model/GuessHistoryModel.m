//
//  GuessHistoryModel.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessHistoryModel.h"

@implementation GuessHistoryModel

+(NSMutableArray *)getModels{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    GuessHistoryModel *model = [[GuessHistoryModel alloc]init];
    model.statu = Uncompleted;
    model.coin = @"";
    model.time = @"2017.10.2";
    model.team = @"KPL秋季赛 - AG超会玩 VS QGhappy";
    model.guess = @"AG超会玩／胜";
    model.cathectic= @"150竞猜币／赔率 1.5";
    model.result = @"比赛未完成";
    
    GuessHistoryModel *model1 = [[GuessHistoryModel alloc]init];
    model1.statu = Win;
    model1.coin = @"280";
    model1.time = @"2017.10.1";
    model1.team = @"KPL秋季赛 - WF VS XQ";
    model1.guess = @"XQ／胜";
    model1.cathectic= @"100竞猜币／赔率 2.8";
    model1.result = @"XQ";
    
    GuessHistoryModel *model2 = [[GuessHistoryModel alloc]init];
    model2.statu = Lose;
    model2.coin = @"100";
    model2.time = @"2017.10.1";
    model2.team = @"KPL秋季赛 - WF VS XQ";
    model2.guess = @"XQ／一血";
    model2.cathectic= @"100竞猜币／赔率 1.0";
    model2.result = @"WF";
    
    for(int i=0;i<3;i++){
        [array addObject:model];
        [array addObject:model1];
        [array addObject:model2];

    }
    return array;
    
}



@end
