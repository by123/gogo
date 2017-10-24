//
//  ScheduleModel.h
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ContentModel.h"

typedef NS_ENUM(NSInteger,ScheduleType){
    Title = 0,
    Content = 1,
};

@interface ScheduleModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (strong, nonatomic) ContentModel *contentModel;

@property (assign, nonatomic) ScheduleType type;


+(NSMutableArray *)getModel;


@end


