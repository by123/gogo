//
//  NetUtil.h
//  gogo
//
//  Created by by.huang on 2017/9/18.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ByNetUtil : NSObject


typedef void(^ByDownloadCallback)(id respondObj);

+(void)get : (NSString *)url;

+(void)get : (NSString *)url params : (NSMutableArray *)arrays;

+(void)post : (NSString *)url;

+(void)post : (NSString *)url params : (NSMutableArray *)arrays;

+(void)post : (NSString *)url jsonStr : (NSString *)jsonStr;

+(void)download : (NSString *)url callback : (ByDownloadCallback) callback;

@end

