//
//  AppDelegate.m
//  gogo
//
//  Created by by.huang on 2017/9/11.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginPage.h"
#import "MainPage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    LoginPage *page = [[LoginPage alloc]init];
    UINavigationController *controller = [[UINavigationController alloc]initWithRootViewController:page];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    return YES;
}




@end
