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

@optional -(void)goScheduleDetailPage : (long)nid;

@optional -(void)goCorpsDetailPage : (long)nid;

@optional -(void)goLoginPage;

@optional -(void)goChargePage;

@optional -(void)goAddressPage;

@optional -(void)goHistoryPage;

@optional -(void)goExchangePage;

@optional -(void)goAboutPage;

@optional -(void)goPersonalPage;

@optional -(void)goGuessPage;

@end

@interface MainPage : BaseViewController

@property (weak, nonatomic) id<MainHandleDelegate> handleDelegate;

@end
