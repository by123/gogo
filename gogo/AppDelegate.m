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
#import <AFNetworkActivityIndicatorManager.h>
#import "AccountManager.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface AppDelegate ()<WXApiDelegate,QQApiInterfaceDelegate>
@end

@implementation AppDelegate{
    LoginPage *loginPage;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *controller;
    if([[AccountManager sharedAccountManager]isLogin]){
        MainPage *page = [[MainPage alloc]init];
        controller = [[UINavigationController alloc]initWithRootViewController:page];
    }else{
        loginPage = [[LoginPage alloc]init];
        controller = [[UINavigationController alloc]initWithRootViewController:loginPage];
    }
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];
    
    [self initNet];
    [self initWechat];
    return YES;
}

-(void)initNet{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];

}


- (void)initWechat{
    [WXApi registerApp:WECHAT_APPID];
}

// 这个方法是用于从微信返回第三方App
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    NSString *host = url.host;
    if([host isEqualToString:@"oauth"]){
        [WXApi handleOpenURL:url delegate:self];
    }else if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }else{
        [QQApiInterface handleOpenURL:url delegate:self];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES;
}



-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        NSString *code =  authResp.code;
        Account *account = [[AccountManager sharedAccountManager] getAccount];
        account.code = code;
        [[AccountManager sharedAccountManager] saveAccount:account];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFY_WECAHT_CALLBACK object:nil];
    }
}





@end
