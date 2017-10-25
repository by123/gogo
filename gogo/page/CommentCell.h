//
//  CommentCell.h
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentModel.h"

@interface CommentCell : UITableViewCell

-(void)setData : (CommentModel *)model;

+(NSString *)identify;

@end
