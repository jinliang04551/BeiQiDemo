//
//  EMLoginViewController.m
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 2018/12/11.
//  Copyright © 2018 XieYajie. All rights reserved.
//

#import "EMLoginViewController.h"

#import <MBProgressHUD/MBProgressHUD.h>

@interface EMLoginViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UITextField *nameField;
@property (nonatomic, strong) UITextField *pswdField;

@property (nonatomic, strong) UIButton *loginTypeButton;
@property (nonatomic) BOOL isLogin;
@property (nonatomic, strong) UILabel* sdkVersionLabel;

@end

@implementation EMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isLogin = false;
    [self _setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}


- (BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark - Subviews

- (void)_setupSubviews
{
    self.contentView = [[UIView alloc] init];
    
    
    self.sdkVersionLabel = [[UILabel alloc] init];
    self.sdkVersionLabel.textColor = UIColor.blueColor;
    self.sdkVersionLabel.font = [UIFont systemFontOfSize:10];
    NSString* version = [NSString stringWithFormat:@"V%@",[[EMClient sharedClient] version]];
    
    self.sdkVersionLabel.text = version;
    self.sdkVersionLabel.textAlignment = NSTextAlignmentCenter;
    self.sdkVersionLabel.alpha = 0.6;

    
    self.nameField = [[UITextField alloc] init];
    self.nameField.backgroundColor = [UIColor grayColor];
    self.nameField.delegate = self;
    self.nameField.borderStyle = UITextBorderStyleNone;
    self.nameField.placeholder = NSLocalizedString(@"userId", nil);
    self.nameField.returnKeyType = UIReturnKeyGo;
    self.nameField.font = [UIFont systemFontOfSize:17];
    self.nameField.rightViewMode = UITextFieldViewModeWhileEditing;
    self.nameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 10)];
    self.nameField.leftViewMode = UITextFieldViewModeAlways;
    self.nameField.layer.cornerRadius = 25;
    self.nameField.layer.borderWidth = 1;
    self.nameField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    

    
    self.pswdField = [[UITextField alloc] init];
    self.pswdField.backgroundColor = [UIColor grayColor];
    self.pswdField.delegate = self;
    self.pswdField.borderStyle = UITextBorderStyleNone;
    self.pswdField.placeholder = NSLocalizedString(@"password", nil);
    self.pswdField.font = [UIFont systemFontOfSize:17];
    self.pswdField.returnKeyType = UIReturnKeyGo;
    self.pswdField.secureTextEntry = YES;
    self.pswdField.clearsOnBeginEditing = NO;
   
    
    self.pswdField.rightViewMode = UITextFieldViewModeAlways;
    self.pswdField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 18, 10)];
    self.pswdField.leftViewMode = UITextFieldViewModeAlways;
    self.pswdField.layer.cornerRadius = 25;
    self.pswdField.layer.borderWidth = 1;
    self.pswdField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    self.loginTypeButton = [[UIButton alloc] init];
    self.loginTypeButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.loginTypeButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginTypeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.loginTypeButton.layer.cornerRadius = 50 * 0.5;
    self.loginTypeButton.backgroundColor = UIColor.blueColor;
    
    [self.loginTypeButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.sdkVersionLabel];
    [self.contentView addSubview:self.pswdField];
    [self.contentView addSubview:self.nameField];
    [self.contentView addSubview:self.loginTypeButton];

    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.sdkVersionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(100.0);
        make.left.right.equalTo(self.contentView);
    }];

    [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sdkVersionLabel.mas_bottom).offset(40);
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.height.equalTo(@55);
    }];
    
    [self.pswdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30);
        make.right.equalTo(self.contentView).offset(-30);
        make.top.equalTo(self.nameField.mas_bottom).offset(20);
        make.height.equalTo(@55);
    }];

    
    [self.loginTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(50.0));
        make.left.equalTo(self.contentView).offset(50.0);
        make.right.equalTo(self.contentView).offset(-50.0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
    }];
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.contentView endEditing:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.nameField.text.length > 0 && self.pswdField.text.length > 0){
        self.isLogin = true;
        [self loginAction];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    textField.layer.borderColor = UIColor.whiteColor.CGColor;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField
{
    UITextRange *rang = textField.markedTextRange;
    if (rang == nil) {
        if(![self.nameField.text isEqualToString:@""] && ![self.pswdField.text isEqualToString:@""]){
            self.isLogin = true;
            return;
        }
        self.isLogin = false;
    }
}

#pragma mark - Action

//清除用户名
- (void)clearUserIdAction
{
    self.nameField.text = @"";
}


- (void)pswdSecureAction:(UIButton *)aButton
{
    aButton.selected = !aButton.selected;
    self.pswdField.secureTextEntry = !self.pswdField.secureTextEntry;
}

- (void)loginAction
{
    if(!self.isLogin) {
        return;
    }
    [self.contentView endEditing:YES];
    
    NSString *name = self.nameField.text;
    NSString *pswd = self.pswdField.text;
    
//    if (isTokenLogin) {
//        [[EMClient sharedClient] loginWithUsername:[name lowercaseString] token:pswd completion:nil];
//        return;
//    }
    
    
    [[EMClient sharedClient] loginWithUsername:[name lowercaseString] password:pswd completion:^(NSString * _Nonnull aUsername, EMError * _Nullable aError) {
        if (aError) {
            EMAlertView *alertView = [[EMAlertView alloc]initWithTitle:@"loginError" message:aError.debugDescription];
            [alertView show];

        }else {
            [[NSNotificationCenter defaultCenter] postNotificationName:ACCOUNT_LOGIN_CHANGED object:@(YES)];
        }
    }];
    
}


@end
