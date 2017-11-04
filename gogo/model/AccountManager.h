//
//  AccountManager.h
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"


#define UID @"uid"
#define ACCESS_TOKEN @"access_token"

@interface AccountManager : NSObject
SINGLETON_DECLARATION(AccountManager);

-(void)saveAccount : (Account *)account;

-(Account *)getAccount;

-(Boolean)isLogin;

-(void)clear;

@end
