//
//  ExchangeModel.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ExchangeStatu){
    InHand,
    Exchanged
};

@interface ExchangeModel : NSObject

@property (copy, nonatomic) NSString *prize;

@property (copy, nonatomic) NSString *coin;

@property (copy, nonatomic) NSString *time;

@property (assign, nonatomic) ExchangeStatu statu;

+(NSMutableArray *)getModels;

@end
