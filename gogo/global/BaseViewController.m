//
//  BaseViewController.m
//  gogo
//
//  Created by by.huang on 2017/9/11.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackgroud];
//    [self setStatuBarBackgroud];
}


-(void)setBackgroud{
    self.view.backgroundColor = c06_backgroud;
}


-(void)hideNavigationBar : (Boolean) hidden{
    self.navigationController.navigationBarHidden = hidden;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(void)setStatuBarBackgroud : (UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}






@end
