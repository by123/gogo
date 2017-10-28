//
//  ExchangeModel.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ExchangeModel.h"

@implementation ExchangeModel

+(NSMutableArray *)getModels{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    ExchangeModel *model = [[ExchangeModel alloc]init];
    model.prize = @"现金红包5元";
    model.coin = @"1000竞猜币";
    model.time = @"2017年10月16日 23:59";
    model.statu = InHand;
    
    ExchangeModel *model2 = [[ExchangeModel alloc]init];
    model2.prize = @"移动话费5元";
    model2.coin = @"1000竞猜币";
    model2.time = @"2017年10月15日 14:25";
    model2.statu = Exchanged;
    
    for(int i=0;i<5;i++){
        [array addObject:model];
        [array addObject:model2];
    }
    return array;

}
@end
