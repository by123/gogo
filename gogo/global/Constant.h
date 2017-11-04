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


#define API_WECHAT_ACCESSTOKEN @"https://api.weixin.qq.com/sns/oauth2/access_token?"
#define API_WECHAT_REFRES_ACCESSTOKEN @"https://api.weixin.qq.com/sns/oauth2/refresh_token?"
#define API_WECHAT_USERINFO @"https://api.weixin.qq.com/sns/userinfo?"
@end
