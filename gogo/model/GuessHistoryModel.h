//
//  GuessHistoryModel.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,GuessHistoryStatu){
    Uncompleted,
    Win,
    Lose,
    
};

@interface GuessHistoryModel : NSObject

@property (assign, nonatomic) GuessHistoryStatu statu;
@property (copy, nonatomic) NSString *coin;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *team;
@property (copy, nonatomic) NSString *guess;
@property (copy, nonatomic) NSString *cathectic;
@property (copy, nonatomic) NSString *result;

+(NSMutableArray *)getModels;

@end
