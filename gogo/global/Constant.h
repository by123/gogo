//
//  Constant.h
//  gogo
//
//  Created by by.huang on 2017/9/11.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constant : NSObject

//请求头
#define PT @"IOS"
#define APPKEY @"test_key"
#define APPSECRET @"test_secret"
#define WECHAT_APPID @"wx3349545f4d083130"
#define WECHAT_APPSECRET @"a38eb57a4e88a6007f5cc44f97ef84e2"
#define QQ_APPID @"1106448485"

//URL
#define RootUrl @"https://gogo.scrats.cn/api/"
#define API_GETVERIFY @"https://gogo.scrats.cn/api/account/sms"
#define API_LOGIN @"https://gogo.scrats.cn/api/account/sms_login"
#define API_BANNER @"https://gogo.scrats.cn/api/core/banner"
#define API_NEWS_LIST @"https://gogo.scrats.cn/api/core/news"
#define API_NEWS_DETAIL @"https://gogo.scrats.cn/api/core/news/"
#define API_COMMENT @"https://gogo.scrats.cn/api/core/comments"
#define API_ADDCOMMENT @"https://gogo.scrats.cn/api/core/comment"
#define API_RACE @"https://gogo.scrats.cn/api/core/races"
#define API_TEAMLIST @"https://gogo.scrats.cn/api/core/teams"
#define API_TEAMDETAIL @"https://gogo.scrats.cn/api/core/team/"
#define API_PAYLIST @"https://gogo.scrats.cn/api/core/coin/plans"
#define API_ALIPAY @"https://gogo.scrats.cn/api/pay/alipay/order/coin_plan"
#define API_USERINFO @"https://gogo.scrats.cn/api/core/user"
#define API_LOGOUT @"https://gogo.scrats.cn/api/account/logout"
#define API_WECHAT_LOGIN @"https://gogo.scrats.cn/api/account/wx_login"
#define API_QQ_LOGIN @"https://gogo.scrats.cn/api/account/qq_login"
#define API_GOODS_LIST @"https://gogo.scrats.cn/api/mall/goods"
#define API_GOODS_DETAIL @"https://gogo.scrats.cn/api/mall/goods/"
#define API_EXCHANGE @"https://gogo.scrats.cn/api/mall/exchange/"



//notification
#define NOTIFY_WECAHT_CALLBACK @"notify_wechat_callback"

@end
