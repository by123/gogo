//
//  GuessView.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessPage.h"
@interface GuessView : UIView

@property (weak, nonatomic) id<GuessDelegate> delegate;

@end
