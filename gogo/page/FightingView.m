//
//  FightingView.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "FightingView.h"

@implementation FightingView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c06_backgroud;
}


@end
