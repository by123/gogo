//
//  VideoCell.h
//  gogo
//
//  Created by by.huang on 2017/11/24.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
#import "BaseViewController.h"
#import "RHPlayerView.h"

@interface VideoCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier controller:(BaseViewController *)controller delegate : (id<RHPlayerViewDelegate>)delegate;

-(void)setData : (NewsModel *)model;

-(void)setVedioPause;

+(NSString *)identify;

@end
