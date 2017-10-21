//
//  NewsCell.m
//  gogo
//
//  Created by by.huang on 2017/10/22.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "NewsCell.h"

@interface NewsCell()

@property (strong ,nonatomic) UILabel *mTitleLabel;
@property (strong ,nonatomic) UILabel *mTypeLabel;
@property (strong ,nonatomic) UIImage *mImage;
@property (strong ,nonatomic) UIView  *lineView;

@end

@implementation NewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = c06_backgroud;
    self.contentView.frame = CGRectMake(0, 0, ScreenWidth, [PUtil getActualHeight:172]);
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = c05_divider;
    _lineView.frame = CGRectMake([PUtil getActualWidth:30],  [PUtil getActualHeight:172]-1, ScreenWidth - ([PUtil getActualWidth:30]*2), 1);
    [self.contentView addSubview:_lineView];
}


-(void)setData : (NewsModel *)model{
    
}

+(NSString *)identify{
    return @"NewsCell";
}


@end
