//
//  MemberModel.h
//  gogo
//
//  Created by by.huang on 2017/10/27.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *introduce;

+(NSMutableArray *)getModels;

@end
