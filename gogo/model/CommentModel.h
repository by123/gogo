//
//  CommentModel.h
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property (copy, nonatomic) NSString *name;

@property (copy, nonatomic) NSString *time;

@property (copy, nonatomic) NSString *imageUrl;

@property (copy, nonatomic) NSString *content;

+(NSMutableArray *)getModels;
@end
