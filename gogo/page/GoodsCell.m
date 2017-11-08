//
//  GoodsCell.m
//  gogo
//
//  Created by by.huang on 2017/10/29.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "GoodsCell.h"

@interface GoodsCell()

@property (strong, nonatomic) UIImageView *showImg;


@end

@implementation GoodsCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self == [super initWithFrame:frame]){
        [self initView];
    }
    return self;
}


-(void)initView{
    
    _showImg = [[UIImageView alloc]initWithFrame:self.bounds];
    _showImg.layer.masksToBounds = YES;
    _showImg.layer.cornerRadius = [PUtil getActualWidth:10];
    _showImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_showImg];
    
}

-(void)setData : (GoodsModel *)goodsModel{
    [_showImg sd_setImageWithURL:[NSURL URLWithString:goodsModel.cover]];

}

+(NSString *)identify{
    return @"GoodsCell";
}

@end

