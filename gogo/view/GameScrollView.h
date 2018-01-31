//
//  GameScrollView.h
//  gogo
//
//  Created by by.huang on 2018/1/31.
//  Copyright © 2018年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleItemModel.h"

@protocol GameScrollViewDelegate

@optional
-(void)OnItemClick:(ScheduleItemModel *)model;

@end

@interface GameScrollView : UIView

-(instancetype)initWithData:(NSMutableArray *)datas;

@property (weak, nonatomic) id<GameScrollViewDelegate> gameScrollViewDelegate;

@end
