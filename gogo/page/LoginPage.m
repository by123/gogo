//
//  LoginPage.m
//  gogo
//
//  Created by by.huang on 2017/10/20.
//  Copyright © 2017年 by.huang. All rights reserved.
//

#import "LoginPage.h"
#import "AccountManager.h"

@interface LoginPage ()<UITextFieldDelegate>

@property (strong, nonatomic) UIImageView *mLogoImage;
@property (strong, nonatomic) UILabel     *mPhoneLabel;
@property (strong, nonatomic) UITextField *mPhoneText;
@property (strong, nonatomic) UILabel     *mVerifyLabel;
@property (strong, nonatomic) UITextField *mVerifyText;
@property (strong, nonatomic) UIButton    *mGetVerifyBtn;
@property (strong, nonatomic) UIButton    *mLoginBtn;
@property (strong, nonatomic) UILabel     *mThirdText;
@property (strong, nonatomic) UIButton    *mWechatBtn;
@property (strong, nonatomic) UIButton    *mQQBtn;
@property (strong, nonatomic) UILabel     *mDisclaimerText;

@end

@implementation LoginPage{
    NSTimer *timer;
    int time;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

-(void)initView{
    [ColorUtil setGradientColor:self.view startColor:c11_bg1 endColor:c12_bg2 director:Top];
    _mLogoImage = [[UIImageView alloc]init];
    UIImage *image = [UIImage imageNamed:@"icon"];
    _mLogoImage.image = image;
    _mLogoImage.frame = CGRectMake([PUtil getActualWidth:255], [PUtil getActualHeight:190], [PUtil getActualWidth:240], [PUtil getActualWidth:240]);
    _mLogoImage.layer.masksToBounds = YES;
    _mLogoImage.layer.cornerRadius =  [PUtil getActualWidth:40]/2;
    [self.view addSubview:_mLogoImage];
    
    UIView *phoneView = [[UIView alloc]init];
    phoneView = [[UITextField alloc]init];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = c13_text1.CGColor;
    phoneView.frame = CGRectMake([PUtil getActualWidth:89], [PUtil getActualHeight:552], [PUtil getActualWidth:572], [PUtil getActualHeight:100]);
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.cornerRadius = [PUtil getActualHeight:100]/2;
    [self.view addSubview:phoneView];
    
    _mPhoneLabel = [[UILabel alloc]init];
    _mPhoneLabel.frame = CGRectMake([PUtil getActualWidth:119], [PUtil getActualHeight:578], [PUtil getActualWidth:102], [PUtil getActualHeight:48]);
    _mPhoneLabel.text = @"手机号";
    _mPhoneLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    _mPhoneLabel.alpha = 0.5;
    _mPhoneLabel.textColor = c08_text;
    [self.view addSubview:_mPhoneLabel];

    _mPhoneText = [[UITextField alloc]init];
    _mPhoneText.frame = CGRectMake([PUtil getActualWidth:119], [PUtil getActualHeight:552], [PUtil getActualWidth:572-230], [PUtil getActualHeight:100]);
    _mPhoneText.textColor = c08_text;
    _mPhoneText.keyboardType =UIKeyboardTypeNumberPad;
    _mPhoneText.delegate = self;
    [self.view addSubview:_mPhoneText];
    
    _mGetVerifyBtn = [[UIButton alloc]init];
    [_mGetVerifyBtn setTintColor:c08_text];
    [_mGetVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    _mGetVerifyBtn.titleLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:24]];
    _mGetVerifyBtn.frame = CGRectMake([PUtil getActualWidth:450],  [PUtil getActualHeight:552], [PUtil getActualWidth:185], [PUtil getActualHeight:100]);
    [_mGetVerifyBtn addTarget:self action:@selector(OnGetVerify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mGetVerifyBtn];
    
    UIView *verifyView = [[UIView alloc]init];
    verifyView = [[UITextField alloc]init];
    verifyView.layer.borderWidth = 1;
    verifyView.layer.borderColor = c13_text1.CGColor;
    verifyView.frame = CGRectMake([PUtil getActualWidth:89], [PUtil getActualHeight:682], [PUtil getActualWidth:572], [PUtil getActualHeight:100]);
    verifyView.layer.masksToBounds = YES;
    verifyView.layer.cornerRadius = [PUtil getActualHeight:100]/2;
    [self.view addSubview:verifyView];

    
    _mVerifyLabel = [[UILabel alloc]init];
    _mVerifyLabel.frame = CGRectMake([PUtil getActualWidth:119], [PUtil getActualHeight:708], [PUtil getActualWidth:102], [PUtil getActualHeight:48]);
    _mVerifyLabel.text = @"验证码";
    _mVerifyLabel.font = [UIFont systemFontOfSize:[PUtil getActualHeight:34]];
    _mVerifyLabel.alpha = 0.5;
    _mVerifyLabel.textColor = c08_text;
    [self.view addSubview:_mVerifyLabel];
    
    _mVerifyText = [[UITextField alloc]init];
    _mVerifyText.frame = CGRectMake([PUtil getActualWidth:119], [PUtil getActualHeight:682], [PUtil getActualWidth:572-230], [PUtil getActualHeight:100]);
    _mVerifyText.textColor = c08_text;
    _mVerifyText.keyboardType =UIKeyboardTypeNumberPad;
    _mVerifyText.delegate = self;
    [self.view addSubview:_mVerifyText];
    
    _mLoginBtn = [[UIButton alloc]init];
    _mLoginBtn.frame = CGRectMake([PUtil getActualWidth:89], [PUtil getActualWidth:812], [PUtil getActualWidth:572], [PUtil getActualHeight:100]);
    [_mLoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    _mLoginBtn.layer.masksToBounds = YES;
    _mLoginBtn.layer.cornerRadius = [PUtil getActualHeight:100]/2;
    [_mLoginBtn addTarget:self action:@selector(OnLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mLoginBtn];
    [ColorUtil setGradientColor:_mLoginBtn startColor:c01_blue endColor:c02_red director:Left];

    _mThirdText = [[UILabel alloc]init];
    _mThirdText.text = @"其他登录方式";
    _mThirdText.alpha = 0.25f;
    _mThirdText.frame = CGRectMake(0, [PUtil getActualHeight:1069], ScreenWidth, [PUtil getActualHeight:28]);
    _mThirdText.textColor = c08_text;
    _mThirdText.font = [UIFont systemFontOfSize:[PUtil getActualHeight:20]];
    _mThirdText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_mThirdText];
    
    _mWechatBtn = [[UIButton alloc]init];
    _mWechatBtn.frame = CGRectMake([PUtil getActualWidth:246], [PUtil getActualWidth:1126], [PUtil getActualWidth:99], [PUtil getActualHeight:99]);
    [_mWechatBtn setTitle:@"微信" forState:UIControlStateNormal];
    _mWechatBtn.layer.masksToBounds = YES;
    _mWechatBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _mWechatBtn.backgroundColor = c01_blue;
    _mWechatBtn.layer.cornerRadius = [PUtil getActualHeight:99]/2;
    [self.view addSubview:_mWechatBtn];
    
    _mQQBtn = [[UIButton alloc]init];
    _mQQBtn.frame = CGRectMake([PUtil getActualWidth:405], [PUtil getActualWidth:1126], [PUtil getActualWidth:99], [PUtil getActualHeight:99]);
    [_mQQBtn setTitle:@"QQ" forState:UIControlStateNormal];
    _mQQBtn.layer.masksToBounds = YES;
    _mQQBtn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    _mQQBtn.backgroundColor = c01_blue;
    _mQQBtn.layer.cornerRadius = [PUtil getActualHeight:99]/2;
    [self.view addSubview:_mQQBtn];
    
    _mDisclaimerText = [[UILabel alloc]init];
    _mDisclaimerText.text = @"隐私策略及免责声明";
    _mDisclaimerText.frame = CGRectMake(0, [PUtil getActualHeight:1286], ScreenWidth, [PUtil getActualHeight:28]);
    _mDisclaimerText.textColor = c14_text2;
    _mDisclaimerText.font = [UIFont systemFontOfSize:[PUtil getActualHeight:20]];
    _mDisclaimerText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_mDisclaimerText];
    
    
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField == _mPhoneText){
        _mPhoneLabel.hidden = YES;
    }else if(textField == _mVerifyText){
        _mVerifyLabel.hidden = YES;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if([textField.text isEqualToString:@""]){
        if(textField == _mPhoneText){
            _mPhoneLabel.hidden = NO;
        }else if(textField == _mVerifyText){
            _mVerifyLabel.hidden = NO;
        }
    }
}

-(void)OnGetVerify{
    time = 59;
    [self handleTimer];
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0) target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
    //todo 获取验证码
}

-(void)handleTimer{
    if(time >= 0){
        [_mGetVerifyBtn setUserInteractionEnabled:NO];
        _mGetVerifyBtn.alpha = 0.5f;
        NSString *text = [NSString stringWithFormat:@"重新获取(%ds)",time];
        [_mGetVerifyBtn setTitle:text forState:UIControlStateNormal];
    }else{
        [_mGetVerifyBtn setUserInteractionEnabled:YES];
        _mGetVerifyBtn.alpha = 1.0f;
        [_mGetVerifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [timer invalidate];
    }
    time -- ;
}

-(void)OnLogin{
    //todo 登录
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_mPhoneText resignFirstResponder];
    [_mVerifyText resignFirstResponder];
}

@end
