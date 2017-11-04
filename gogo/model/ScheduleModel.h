//
//  ScheduleModel.h
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeamModel.h"

typedef NS_ENUM(NSInteger,ScheduleType){
    Title = 0,
    Content = 1,
};

@interface ScheduleModel : NSObject

@property (assign, nonatomic) ScheduleType type;

@property (assign, nonatomic) long race_id;
@property (assign, nonatomic) long race_info_id;
@property (assign, nonatomic) long game_id;
@property (copy, nonatomic) NSString* score_a;
@property (copy, nonatomic) NSString* score_b;
@property (copy, nonatomic) NSString* race_ts;
@property (copy, nonatomic) NSString* create_ts;
@property (copy, nonatomic) NSString* status;

@property (strong, nonatomic) TeamModel *aTeamModel;
@property (strong, nonatomic) TeamModel *bTeamModel;




@end


