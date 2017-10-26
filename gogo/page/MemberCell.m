//
//  MemberCell.m
//  gogo
//
//  Created by by.huang on 2017/10/27.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "MemberCell.h"

@interface MemberCell()
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *introduceLabel;
@property (strong, nonatomic) UIView *headView;

@end

@implementation MemberCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = c06_backgroud;
    
    _headView = [[UIView alloc]init];
    _headView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualWidth:30], [PUtil getActualWidth:90], [PUtil getActualWidth:90]);
    _headView.layer.masksToBounds = YES;
    _headView.layer.cornerRadius = [PUtil getActualWidth:90]/2;
    _headView.backgroundColor = c01_blue;
    [self.contentView addSubview:_headView];
    
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.frame = CGRectMake([PUtil getActualWidth:140], [PUtil getActualHeight:30],[PUtil getActualWidth:136], [PUtil getActualHeight:48]);
    _nameLabel.textColor =c08_text;
    _nameLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    [self.contentView addSubview:_nameLabel];
    
    _introduceLabel = [[UILabel alloc]init];
    _introduceLabel.frame = CGRectMake([PUtil getActualWidth:140], [PUtil getActualHeight:86],ScreenWidth - [PUtil getActualWidth:170], [PUtil getActualHeight:100]);
    _introduceLabel.textColor =c08_text;
    _introduceLabel.numberOfLines = 0;
    _introduceLabel.alpha = 0.5f;
    _introduceLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _introduceLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:30]];
    [self.contentView addSubview:_introduceLabel];
    
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = c05_divider;
    lineView.frame = CGRectMake([PUtil getActualWidth:30], [PUtil getActualHeight:200]-1, ScreenWidth - [PUtil getActualWidth:30], 1);
    [self.contentView addSubview:lineView];
    
}

-(void)setData : (MemberModel *)model{
    _nameLabel.text = model.name;
    _introduceLabel.text = model.introduce;
}

+(NSString *)identify{
    return @"MemberCell";
}

@end
