//
//  OnePage.h
//  gogo
//
//  Created by by.huang on 2017/9/19.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "BaseViewController.h"
#import "SDCycleScrollView.h"
#import "MainPage.h"

@interface HomeView : UIView<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) id<MainHandleDelegate> handleDelegate;

@end
