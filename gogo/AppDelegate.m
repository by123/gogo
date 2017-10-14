//
//  AppDelegate.m
//  gogo
//
//  Created by by.huang on 2017/9/11.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "AppDelegate.h"
#import "QLMainPage.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    UIWindow *window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    QLMainPage *page = [[QLMainPage alloc]init];
    UINavigationController *controller = [[UINavigationController alloc]initWithRootViewController:page];
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    return YES;
}




@end
