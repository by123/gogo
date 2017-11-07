//
//  GuessPage.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//


#import "BaseViewController.h"

@protocol GuessDelegate <NSObject>

@optional -(void)goLivePage;

@end

@interface GuessPage : BaseViewController<GuessDelegate>


@end
