//
//  NewsModel.h
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (assign,nonatomic) long nid;
@property (copy,nonatomic) NSString *title;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *comments;
@property (copy,nonatomic) NSString *imageUrl;

+(NewsModel *)getModel;

@end
