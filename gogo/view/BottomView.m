//
//  BottomView.m
//  gogo
//
//  Created by by.huang on 2017/10/23.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "BottomView.h"

#define TabHeight [PUtil getActualHeight:100]

@interface BottomView()

@property (strong, nonatomic) id<BottomViewDelegate> delegate;

@end

@implementation BottomView{
    UIButton *selectButton;
}

-(instancetype)initWithTitles:(NSArray *)titles delegate:(id<BottomViewDelegate>)delegate{
    if(self == [super init]){
        self.delegate = delegate;
        [self initView : titles];
    }
    return self;
}


-(void)initView : (NSArray*) titles{
    self.frame = CGRectMake(0, ScreenHeight - TabHeight, ScreenWidth, TabHeight);
    self.backgroundColor = c07_bar;
    if(titles!=nil &&  [titles count]> 0){
        int width = ScreenWidth / [titles count];
        for(int i= 0 ; i < [titles count] ; i++){
            UIButton *button = [[UIButton alloc]init];
            button.tag = i;
            button.frame = CGRectMake(width * i, 0, width, TabHeight);
            [button setTitle:[titles objectAtIndex:i]  forState:UIControlStateNormal];
            if(i == 0){
                selectButton = button;
                [button setTitleColor:c01_blue forState:UIControlStateNormal];
            }else{
                [button setTitleColor:c10_icon forState:UIControlStateNormal];
            }
            [button addTarget:self action:@selector(OnButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
}

-(void)OnButtonClick : (id)sender{
    UIButton *button = sender;
    [button setTitleColor:c01_blue forState:UIControlStateNormal];
    [selectButton setTitleColor:c10_icon forState:UIControlStateNormal];
    selectButton = button;
    if(self.delegate){
        [self.delegate OnTabSelected:button.tag];
    }
}

@end
