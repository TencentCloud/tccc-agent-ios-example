//
//  ViewController.m
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2023/5/17.
//

#import "ViewController.h"
#include "tccc/include/ITCCCWorkstation.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UITextView *txtVersion;

@end

@implementation ViewController
using namespace tccc;
ITCCCWorkstation* tcccSDK;

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建用户名输入框
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 40)];
    self.usernameField.placeholder = @"请输入用户名";
    self.usernameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.usernameField];
    
    // 创建密码输入框
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, self.view.bounds.size.width - 40, 40)];
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordField.secureTextEntry = YES;
    [self.view addSubview:self.passwordField];
    
    // 创建登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(20, 220, self.view.bounds.size.width - 40, 40);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    tcccSDK = getTCCCShareInstance();
    const char *  version = tcccSDK->getSDKVersion();
    
    // 创建版本文本
    self.txtVersion = [[UITextView alloc] initWithFrame:CGRectMake(20, 750, self.view.bounds.size.width - 40, 40)];
    self.txtVersion.text =  [NSString stringWithUTF8String:version];
    self.txtVersion.textAlignment = NSTextAlignmentCenter;
    self.txtVersion.font = [UIFont systemFontOfSize:12];
    self.txtVersion.textColor = [UIColor blackColor];
    self.txtVersion.editable = false;
    self.txtVersion.dataDetectorTypes = UIDataDetectorTypeAll;
    // 添加UITextView到视图中
    [self.view addSubview:self.txtVersion];
    
    NSLog(@"tccc SDK version: %s",version);
}

- (void)loginButtonTapped:(UIButton *)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    // 在这里处理登录逻辑，例如验证用户名和密码是否正确
    // 获取另一个Storyboard的实例
    UIStoryboard *callingStoryboard = [UIStoryboard storyboardWithName:@"Calling" bundle:nil];
    
    // 获取另一个Storyboard中的视图控制器
    UIViewController *callingViewController = [callingStoryboard instantiateInitialViewController];
    
    // 获取当前Storyboard的根视图控制器
    UINavigationController *navController = (UINavigationController *)self.view.window.rootViewController;

    // 关闭当前Storyboard
    [navController dismissViewControllerAnimated:NO completion:nil];

    // 跳转到另一个Storyboard
    [navController presentViewController:callingViewController animated:YES completion:nil];
    
}

@end
