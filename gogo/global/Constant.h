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
@end
