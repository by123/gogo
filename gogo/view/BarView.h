//
//  BarView.h
//  gogo
//
//  Created by by.huang on 2017/10/26.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol BarViewDelegate <NSObject>

@optional -(void)onBackClick;

@end

@interface BarView : UIView

-(instancetype)initWithTitle:(NSString *)title page : (BaseViewController *)cPage;

-(instancetype)initWithTitle:(NSString *)title page : (BaseViewController *)cPage delegate : (id<BarViewDelegate>)delegate;

@end
