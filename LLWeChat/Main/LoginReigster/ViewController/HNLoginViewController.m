//
//  HNLoginViewController.m
//  LLWeChat
//
//  Created by 谌文 on 17/10/6.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "HNLoginViewController.h"
#import "HNTabBarMainFourController.h"
#import "LLAccoutElectTextFiledView.h"
#import "HNClientManager.h"


@interface HNLoginViewController ()

@property (nonatomic, strong) UILabel                       *titleLabel ;              // 微信
@property (nonatomic, strong) LLAccoutElectTextFiledView    *accountView ;            //账号输入框
@property (nonatomic, strong) LLAccoutElectTextFiledView    *secretView ;           //账号输入框
@property (nonatomic, strong) UIButton                      *loginBtn;                      // 登陆按钮
@property (nonatomic, strong) UIButton                      *registerBtn;                      // 注册按钮

@end

@implementation HNLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createUI];
    [self addFrame];
}


- (void)loginClick:(UIButton*)btn{
    
}


#pragma mark - 用户登录

- (void)loginBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    
    
    
//    HNTabBarMainFourController *MainVC = [[HNTabBarMainFourController alloc]init];
//    self.view.window.rootViewController = MainVC;
    
    //    [UIAlertController alertWithMessage:@"d" formVc:self Confirmed:nil];
    
//    [UIAlertController alertWithTitleClickWhiteToCancle:@"正确" message:@"爱情" comfirTitle:@"呵呵" formVc:self Confirmed:nil];
    
    
    [[HNClientManager sharedManager] loginWithUsername:self.accountView.textfield.text password:self.secretView.textfield.text];
    
}

- (void)registerBtnClick:(UIButton*)sender {
    [self.view endEditing:YES];
    
    [[HNClientManager sharedManager] registerWithUsername:self.accountView.textfield.text password:self.secretView.textfield.text];
}


- (void)textFieldDidChange:(UITextField *)sender {
    if (self.accountView.textfield.text.length > 0 && self.secretView.textfield.text.length > 0) {
        self.loginBtn.enabled = YES;
        self.registerBtn.enabled = YES;
    }else {
        self.loginBtn.enabled = NO;
        self.registerBtn.enabled = NO;
    }
}


// 设置UI
- (void)createUI{
    [self.view addSubview:self.accountView];
    [self.view addSubview:self.secretView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
}

// 设置frame
- (void)addFrame{
    _accountView.frame = CGRectMake(0, 120, ScreenWidth, 26);
    _secretView.frame = CGRectMake(0, _accountView.bottom+10, ScreenWidth, 35);
    [_accountView addBorderWithColor:[UIColor grayColor] andWidth:1 andPostion:BOTTOM startPosition:15 lenght:_accountView.width - 30];
    [_secretView addBorderWithColor:[UIColor grayColor] andWidth:1 andPostion:BOTTOM startPosition:15 lenght:_accountView.width - 30];
    _loginBtn.frame = CGRectMake(ScreenWidth*0.5-100, _secretView.bottom + 60, 80, 40);
    _registerBtn.frame = CGRectMake(ScreenWidth*0.5+20, _secretView.bottom + 60, 80, 40);
}

// 账号输入框
- (LLAccoutElectTextFiledView*)accountView{
    if (!_accountView) {
        _accountView = [[LLAccoutElectTextFiledView alloc]init];
        _accountView.nameLabel.text = @"账号";
        _accountView.textfield.placeholder = @"请输入账号";
        _accountView.textfield.delegate = self;
    }
    return _accountView;
}

// 密码输入框
- (LLAccoutElectTextFiledView*)secretView{
    if (!_secretView) {
        _secretView = [[LLAccoutElectTextFiledView alloc]init];
        _secretView.nameLabel.text = @"密码";
        _secretView.textfield.placeholder = @"请输入密码";
        _secretView.textfield.delegate = self;
    }
    return _secretView;
}


// 登陆按钮
- (UIButton*)loginBtn{
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc]init];
        [_loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
        _loginBtn.backgroundColor = [UIColor redColor];
        [_loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}


// 注册按钮
- (UIButton*)registerBtn{
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc]init];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        _registerBtn.backgroundColor = [UIColor redColor];
        [_registerBtn addTarget:self action:@selector(registerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}



@end
