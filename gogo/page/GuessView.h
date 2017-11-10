//
//  GuessView.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuessPage.h"
#import "GuessButton.h"
#import "BettingItemModel.h"
@interface GuessView : UIView<GuessButtonDelegate>

-(instancetype)initWithDatas : (NSMutableArray *)datas;

@property (weak, nonatomic) id<GuessDelegate> delegate;

-(void)restoreItems;

@end
