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
    [self hideNavigationBar:YES];
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)setBackgroud{
    self.view.backgroundColor = c06_backgroud;
}


-(void)hideNavigationBar : (Boolean) hidden{
    self.navigationController.navigationBarHidden = hidden;
}


-(void)setStatuBarBackgroud : (UIColor *)color{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

-(void)setRedBlueStatuBar{
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    [ColorUtil setGradientColor:statusBar startColor:c01_blue endColor:c02_red director:Left];
}

-(void)pushPage:(BaseViewController *)targetPage{
    [self.navigationController pushViewController:targetPage animated:YES];
}





@end
