//
//  ChatView.h
//  gogo
//
//  Created by by.huang on 2017/12/10.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatView : UIView

-(instancetype)init;

- (void)keyboardWillChangeFrame:(NSNotification *)notification;

@end
