//
//  MallView.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HOT @"hot"
#define EQUIPMENT @"equipment"
#define LUCKYMONEY @"lucky_money"
#define GAMEAROUND @"game_around"
#define VIRTUAL @"virtual"

@interface GoodsView : UIView

@property (copy, nonatomic) NSString *type;

-(instancetype)initWithType : (NSString *)type;

@end
