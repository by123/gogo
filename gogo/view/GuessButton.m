//
//  GuessButton.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GuessButton.h"

@interface GuessButton()

@property (strong, nonatomic) UILabel *mTitleLabel;
@property (strong, nonatomic) UILabel *mGuessLabel;

@end

@implementation GuessButton{
    NSString *titleStr;
    NSString *guessStr;
}

-(instancetype)initWithTitle:(NSString *)title guess:(NSString *)guess{
    if(self == [super init]){
        titleStr = title;
        guessStr = guess;
        [self initView];
    }
    return self;
}

-(void)initView{
    self.frame = CGRectMake(0, 0, [PUtil getActualWidth:216], [PUtil getActualHeight:97]);
    self.layer.borderWidth = 1;
    self.layer.borderColor = [c01_blue CGColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = [PUtil getActualHeight:6];
    self.backgroundColor = c06_backgroud;
    
    _mTitleLabel =  [[UILabel alloc]init];
    _mTitleLabel.text = titleStr;
    _mTitleLabel.textColor = c08_text;
    _mTitleLabel.textAlignment = NSTextAlignmentCenter;
    _mTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:28]];
    _mTitleLabel.frame = CGRectMake(0, [PUtil getActualHeight:12], [PUtil getActualWidth:216],[PUtil getActualHeight:40]);
    [self addSubview:_mTitleLabel];
    
    _mGuessLabel =  [[UILabel alloc]init];
    _mGuessLabel.text = guessStr;
    _mGuessLabel.textColor = c02_red;
    _mGuessLabel.textAlignment = NSTextAlignmentCenter;
    _mGuessLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _mGuessLabel.frame = CGRectMake(0, [PUtil getActualHeight:52], [PUtil getActualWidth:216],[PUtil getActualHeight:33]);
    [self addSubview:_mGuessLabel];
}

@end