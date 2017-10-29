//
//  GuessView.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessView.h"
#import "GuessListModel.h"

@implementation GuessView{
    NSMutableArray *models;
}

-(instancetype)init{
    if(self == [super init]){
        models = [GuessListModel models];
        [self initView];
    }
    return self;
}

-(void)initView{
    self.backgroundColor = c06_backgroud;
}

@end
