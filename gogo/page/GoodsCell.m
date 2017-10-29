//
//  GoodsCell.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell()

@property (strong, nonatomic) UIView *showImg;


@end

@implementation GoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    self.contentView.backgroundColor = c06_backgroud;
    
    _showImg = [[UIView alloc]init];
    _showImg.backgroundColor = c01_blue;
//    _showImg.frame = CGRectMake(0, 0, PUtil getActualWidth:3, <#CGFloat height#>)
    [self.contentView addSubview:_showImg];
    
}

-(void)setData:(NSString *)imgUrl{
    
}

+(NSString *)identify{
    return @"GoodsCell";
}

@end

