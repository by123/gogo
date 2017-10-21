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
#define PHONE @"phone"
#define NAME @"name"
#define AVATRA @"avatar"

@interface AccountManager : NSObject
SINGLETON_DECLARATION(AccountManager);

-(void)saveAccount : (Account *)account;

-(Account *)getAccount;


@end
