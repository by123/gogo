//
//  InsetTextField.m
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "InsetTextField.h"

@implementation InsetTextField{
    UIEdgeInsets edgeInsets;
}

-(instancetype)initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets{
    if(self == [super initWithFrame:frame]){
        edgeInsets = insets;
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,edgeInsets.left,0);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,edgeInsets.left,0);
}

@end
