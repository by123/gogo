//
//  PriceCell.h
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceCell : UITableViewCell

-(void)setData : (NSString *)title hideline : (Boolean)hideline;

-(void)setSelect : (Boolean)select;

+(NSString *)identify;

@end
