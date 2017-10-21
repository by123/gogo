//
//  ColorUtil.m
//
//  Created by mark.zhang on 6/5/15.
//  Copyright (c) 2015 idreamsky. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil



+ (UIColor *)colorWithHexString:(NSString *)stringToConvert
{
    if ([stringToConvert hasPrefix:@"0x"]) {
        stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0x" withString:@"#"];
    }
    else if ([stringToConvert hasPrefix:@"0X"]) {
        stringToConvert = [stringToConvert stringByReplacingOccurrencesOfString:@"0X" withString:@"#"];
    }
    
    return [self colorWithHexString:stringToConvert alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert alpha:(CGFloat)alpha
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return DEFAULT_VOID_COLOR;
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return DEFAULT_VOID_COLOR;
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r/255.0f)
                           green:((float) g/255.0f)
                            blue:((float) b/255.0f)
                           alpha:alpha];
}


+ (void)setGradientColor : (UIView *)view startColor: (UIColor *)startColor endColor : (UIColor *)endColor director : (ColorDirector)director{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = view.bounds;
    gradient.colors = [NSArray arrayWithObjects:
                       (id)startColor.CGColor,
                       (id)endColor.CGColor, nil];
    if(director == Left)
    {
        gradient.startPoint = CGPointMake(0, 0.5);
        gradient.endPoint = CGPointMake(1, 0.5);
    }else if(director == Top){
        gradient.startPoint = CGPointMake(0.5, 0);
        gradient.endPoint = CGPointMake(0.5, 1);
    }
    [view.layer addSublayer:gradient];
}
@end
