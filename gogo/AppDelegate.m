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
@interface AppDelegate ()<WXApiDelegate>
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
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}


-(void)onReq:(BaseReq *)req{
    
}

-(void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        NSString *code =  authResp.code;
        [self requestLogin:code];
    }
}

-(void)requestLogin : (NSString *)code{
    NSString *urlStr = [NSString stringWithFormat:@"%@appid=%@&secret=%@&code=%@&grant_type=authorization_code",API_WECHAT_ACCESSTOKEN,WECHAT_APPID,WECHAT_APPSECRET,code];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *access_token = [dic objectForKey:@"access_token"];
            [self requestUserInfo:access_token];
        }
    }];
    [dataTask resume];
}

-(void)refreshAcceeToken : (NSString *)access_token{
    NSString *urlStr = [NSString stringWithFormat:@"%@appid=%@&refresh_token=%@&grant_type=refresh_token",API_WECHAT_REFRES_ACCESSTOKEN,WECHAT_APPID,access_token];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSString *refresh_token = [dic objectForKey:@"access_token"];
            [self requestUserInfo:refresh_token];
        }
    }];
    [dataTask resume];
}

-(void)requestUserInfo : (NSString *)access_token{
    NSString *urlStr = [NSString stringWithFormat:@"%@access_token=%@&openid=OPENID",API_WECHAT_USERINFO,access_token];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    NSURLSession *urlSession = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSString *nickname = [dic objectForKey:@"nickname"];
//            int sex = [[dic objectForKey:@"sex"] intValue];
//            NSString *city = [dic objectForKey:@"city"];
//            NSString *province = [dic objectForKey:@"province"];
            NSString *headimgurl = [dic objectForKey:@"headimgurl"];

            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setValue:nickname forKey:@"nickname"];
            [userDefaults setValue:headimgurl forKey:@"headimgurl"];
            [userDefaults synchronize];
            
        }
    }];
    [dataTask resume];
}





@end
