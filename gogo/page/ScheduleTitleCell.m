//
//  ScheduleTitleCell.m
//  gogo
//
//  Created by by.huang on 2017/10/25.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "ScheduleTitleCell.h"

@interface ScheduleTitleCell()

@property (strong, nonatomic) UILabel *mTitleLabel;

@end

@implementation ScheduleTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    
    self.contentView.backgroundColor = c06_backgroud;
    _mTitleLabel = [[UILabel alloc]init];
    _mTitleLabel.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:24], ScreenWidth, [PUtil getActualHeight:84]);
    _mTitleLabel.textColor = c09_tips;
    _mTitleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:30]];
    _mTitleLabel.numberOfLines = 0;
    _mTitleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [self.contentView addSubview:_mTitleLabel];
    
 
}


-(void)setData : (NSString *)title{
    _mTitleLabel.text = title;

}

+(NSString *)identify{
    return @"ScheduleTitleCell";
}
@end
