//
//  MainPage.h
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "BaseViewController.h"

@protocol MainHandleDelegate <NSObject>

@optional -(void)goNewsDetailPage : (long)nid;

@end

@interface MainPage : BaseViewController

@property (strong, nonatomic) id<MainHandleDelegate> handleDelegate;

@end
