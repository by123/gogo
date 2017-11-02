//
//  AccountManager.m
//  gogo
//
//  Created by by.huang on 2017/10/21.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "AccountManager.h"

@implementation AccountManager
SINGLETON_IMPLEMENTION(AccountManager);

-(void)saveAccount:(Account *)account{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:account.uid forKey:UID];
    [userDefaults setValue:account.access_token forKey:ACCESS_TOKEN];
}

-(Account *)getAccount{
    Account *account = [[Account alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    account.uid = [userDefaults objectForKey:UID];
    account.access_token = [userDefaults objectForKey:ACCESS_TOKEN];
    return account;
}

@end
