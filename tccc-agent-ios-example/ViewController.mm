//
//  ViewController.m
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2023/5/17.
//

#import "ViewController.h"
#import "GenerateTestUserToken.h"
#include "tccc/include/ITCCCWorkstation.h"
#include <string>

@interface ViewController ()

@property (nonatomic, strong) UITextField *seatUserIdField;
@property (nonatomic, strong) UITextField *tokenField;
@property (nonatomic, strong) UIButton *getTokenButton;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *isLoginButton;
@property (nonatomic, strong) UIButton *logoutButton;

@property (nonatomic, strong) UIButton *startCallButton;
@property (nonatomic, strong) UIButton *hangupButton;
@property (nonatomic, strong) UIButton *speakerButton;
@property (nonatomic, strong) UIButton *muteButton;


@property (nonatomic, strong) UITextView *txtVersion;

@end

@implementation ViewController

using namespace tccc;

class TCCCCallbackImpl:public ITCCCCallback
{
private:
    inline std::string makeString(const char* str) {
        return (nullptr == str ? "" : std::string(str));
    }
public:
    TCCCCallbackImpl() {
    }
    ~TCCCCallbackImpl() {}
    void onError(TCCCError errCode, const char* errMsg, void* extraInfo) {
        std::string copyErrMsg = makeString(errMsg);
        if ([NSThread isMainThread]) {
            NSLog(@"<== onError errCode: %d , errMsg: %s",errCode,copyErrMsg.c_str());
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"<== onError errCode: %d , errMsg: %s",errCode,copyErrMsg.c_str());
        });
    }
    
    void onWarning(TCCCCWarning warningCode, const char* warningMsg, void* extraInfo) {
        std::string copyWarningMsg = makeString(warningMsg);
        if ([NSThread isMainThread]) {
            NSLog(@"<== onWarning warningCode: %d , warningMsg: %s",warningCode,copyWarningMsg.c_str());
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"<== onWarning warningCode: %d , warningMsg: %s",warningCode,copyWarningMsg.c_str());
        });
    }
    
    void onNewSession(TCCCSessionInfo info) {
        std::string copySessionID = makeString(info.sessionID);
        std::string copyFrom = makeString(info.fromAor);
        std::string copyTo = makeString(info.toAor);
        std::string copyJson = makeString(info.customHeaderJson);
        auto sessionDirection = info.sessionDirection;
        if ([NSThread isMainThread]) {
            NSLog(@"<== onNewSession sessionID: %s , fromAor: %s , toAor: %s , sessionDirection: %d",copySessionID.c_str(),copyFrom.c_str(),copyTo.c_str(),info.sessionDirection);
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"<== onNewSession sessionID: %s , fromAor: %s , toAor: %s , sessionDirection: %d",copySessionID.c_str(),copyFrom.c_str(),copyTo.c_str(),info.sessionDirection);
        });
    };
    
    void onEnded(EndedReason reason, const char* reasonMessage, const char* sessionId) {
        std::string copyReasonMessage = makeString(reasonMessage);
        std::string copySessionID = makeString(sessionId);
        if (reason == EndedReason::Error) {
            // 系统异常 + reasonMessage
        } else if (reason == EndedReason::Timeout) {
           // 超时挂断
        } else if (reason == EndedReason::LocalBye) {
            // 你已挂断
        } else if (reason == EndedReason::RemoteBye) {
            // 对方已挂断
        } else if (reason == EndedReason::Rejected) {
            // 对方已拒接
        } else if (reason == EndedReason::RemoteCancel) {
            // 对方已取消
        }
        if ([NSThread isMainThread]) {
            
            return;
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                
            });
        }
    }
    
    void onAccepted(const char* sessionId) {
        std::string copySessionID = makeString(sessionId);
        if ([NSThread isMainThread]) {
            NSLog(@"<== onAccepted sessionID: %s ",copySessionID.c_str());
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"<== onAccepted sessionID: %s ",copySessionID.c_str());
        });
    };
    
    void onAudioVolume(TCCCVolumeInfo* volumeInfo) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }
    
    void onNetworkQuality(TCCCQualityInfo localQuality, TCCCQualityInfo* remoteQuality,
                          uint32_t remoteQualityCount) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
    }
private:
    
};

class TCCCLoginCallbackImpl : public ITXValueCallback<TCCCLoginInfo> {
private:
    inline std::string makeString(const char* str) {
        return (nullptr == str ? "" : std::string(str));
    }
public:
    TCCCLoginCallbackImpl() {
        
    }
    ~TCCCLoginCallbackImpl() override {}
    void OnSuccess(const TCCCLoginInfo &value) override {
        std::string copyUserId = makeString(value.userId);
        if ([NSThread isMainThread]) {
            NSLog(@"<== login OnSuccess userId: %s",copyUserId.c_str());
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"<== login OnSuccess userId: %s",copyUserId.c_str());
            });
        }
    }
    
    void OnError(TCCCError error_code, const char *error_message) override {
        std::string copyErrMsg = makeString(error_message);
        if ([NSThread isMainThread]) {
            NSLog(@"<== login onError errCode: %d , errMsg: %s",error_code,copyErrMsg.c_str());
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"<== login onError errCode: %d , errMsg: %s",error_code,copyErrMsg.c_str());
            });
        }
    }
};

class TCCCCommonCallback : public ITXCallback {
private:
    NSString* mFunName;
    inline std::string makeString(const char* str) {
        return (nullptr == str ? "" : std::string(str));
    }
public:
    TCCCCommonCallback(NSString* funName) {
        mFunName = funName;
    }
    ~TCCCCommonCallback() override {
        
    }
    void OnSuccess() override {
        if ([NSThread isMainThread]) {
            NSLog(@"<== %@ OnSuccess",mFunName);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"<== %@ OnSuccess",mFunName);
            });
        }
    }
    
    void OnError(TCCCError error_code, const char *error_message) override {
        std::string copyErrMsg = makeString(error_message);
        if ([NSThread isMainThread]) {
            NSLog(@"<== %@ OnError errCode: %d , errMsg: %s",mFunName,error_code,copyErrMsg.c_str());
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"<== %@ onError errCode: %d , errMsg: %s",mFunName,error_code,copyErrMsg.c_str());
            });
        }
    }
};

ITCCCWorkstation* tcccSDK = nullptr;
TCCCCallbackImpl* tcccCallback = nullptr;
TCCCLoginCallbackImpl* loginCallBackImpl = nullptr;
TCCCCommonCallback* startCallCallbackImpl = nullptr;
TCCCCommonCallback* checkLoginCallbackImpl = nullptr;
TCCCCommonCallback* logoutCallbackImpl = nullptr;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self initTcccSDK];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    tcccSDK->removeCallback(tcccCallback);
    destroyTCCCShareInstance();
    tcccSDK = nullptr;
    if (nullptr != tcccCallback) {
        delete  tcccCallback;
        tcccCallback = nullptr;
    }
    if (nullptr != loginCallBackImpl) {
        delete  loginCallBackImpl;
        loginCallBackImpl = nullptr;
    }
    if (nullptr != startCallCallbackImpl) {
        delete  startCallCallbackImpl;
        startCallCallbackImpl = nullptr;
    }
    if (nullptr != checkLoginCallbackImpl) {
        delete  checkLoginCallbackImpl;
        checkLoginCallbackImpl = nullptr;
    }
    if (nullptr != logoutCallbackImpl) {
        delete  logoutCallbackImpl;
        logoutCallbackImpl = nullptr;
    }
}

- (void)initUI {
    // 创建UserId输入框
    self.seatUserIdField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 40)];
    self.seatUserIdField.placeholder = @"请输入坐席ID";
    self.seatUserIdField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.seatUserIdField];
    self.seatUserIdField.text = USERID;
    
    // 创建Token输入框
    self.tokenField = [[UITextField alloc] initWithFrame:CGRectMake(20, 160, self.view.bounds.size.width - 40, 40)];
    self.tokenField.placeholder = @"请输入先获取token";
    self.tokenField.borderStyle = UITextBorderStyleRoundedRect;
    self.tokenField.secureTextEntry = YES;
    [self.view addSubview:self.tokenField];
    
    // 创建获取token按钮
    self.getTokenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.getTokenButton.frame = CGRectMake(20, 220, 80, 40);
    [self.getTokenButton setTitle:@"获取token" forState:UIControlStateNormal];
    [self.getTokenButton addTarget:self action:@selector(getTokenButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getTokenButton];
    
    // 创建登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(100, 220, 80, 40);
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    //
    self.isLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.isLoginButton.frame = CGRectMake(155, 220, 80, 40);
    [self.isLoginButton setTitle:@"isLogin" forState:UIControlStateNormal];
    [self.isLoginButton addTarget:self action:@selector(isLogoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.isLoginButton];
    
    // 创建退出登录按钮
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.logoutButton.frame = CGRectMake(210, 220, 80, 40);
    [self.logoutButton setTitle:@"退出" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
    
    // 创建外呼按钮
    self.startCallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startCallButton.frame = CGRectMake(20, 270, 50, 50);
    [self.startCallButton setTitle:@"外呼" forState:UIControlStateNormal];
    [self.startCallButton addTarget:self action:@selector(startCallButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startCallButton];
    
    // 创建挂断按钮
    self.hangupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hangupButton.frame = CGRectMake(80, 270, 50, 50);
    [self.hangupButton setTitle:@"挂断" forState:UIControlStateNormal];
    [self.hangupButton addTarget:self action:@selector(hangupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hangupButton];
    
    // 创建静音按钮
    self.muteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.muteButton.frame = CGRectMake(20, 320, 50, 50);
    [self.muteButton setTitle:@"静音" forState:UIControlStateNormal];
    [self.muteButton addTarget:self action:@selector(muteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.muteButton];
    
    // 创建扬声器按钮
    self.speakerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.speakerButton.frame = CGRectMake(80, 320, 50, 50);
    [self.speakerButton setTitle:@"扬声器" forState:UIControlStateNormal];
    [self.speakerButton addTarget:self action:@selector(speakerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.speakerButton];
    
    // 创建版本文本
    self.txtVersion = [[UITextView alloc] initWithFrame:CGRectMake(20, 750, self.view.bounds.size.width - 40, 40)];
    self.txtVersion.textAlignment = NSTextAlignmentCenter;
    self.txtVersion.font = [UIFont systemFontOfSize:12];
    self.txtVersion.textColor = [UIColor blackColor];
    self.txtVersion.editable = false;
    self.txtVersion.dataDetectorTypes = UIDataDetectorTypeAll;
    // 添加UITextView到视图中
    [self.view addSubview:self.txtVersion];
}

- (void)initTcccSDK {
    tcccSDK = getTCCCShareInstance();
    tcccCallback = new TCCCCallbackImpl();
    tcccSDK->addCallback(tcccCallback);
    // 获取TCCC SDK版本号
    const char *  version = tcccSDK->getSDKVersion();
    self.txtVersion.text =  [NSString stringWithUTF8String:version];
    NSLog(@"tccc SDK version: %s",version);
}

- (void)getTokenButtonTapped:(UIButton *)sender {
    self.getTokenButton.selected = true;
    // 获取token
    [GenerateTestUserToken genTestUserToken:USERID completion:^(NSString *token, NSError *error) {
        self.getTokenButton.selected = false;
        if (error) {
            NSLog(@"请求失败: %@", error.localizedDescription);
        } else {
            self.tokenField.text = token;
            NSLog(@"请求成功,token= %@", token);
        }
    }];
}

- (void)loginButtonTapped:(UIButton *)sender {
    if (nullptr == loginCallBackImpl) {
        loginCallBackImpl = new TCCCLoginCallbackImpl();
    }
    TCCCLoginParams param;
    param.userId = self.seatUserIdField.text.UTF8String;
    param.token = self.tokenField.text.UTF8String;
    param.sdkAppId = SDKAppID;
    // 必须知道为坐席模式
    param.type = TCCCLoginType::Agent;
    // 登录
    tcccSDK->login(param,loginCallBackImpl);
}

- (void)isLogoutButtonTapped:(UIButton *)sender {
    if (nullptr == checkLoginCallbackImpl) {
        checkLoginCallbackImpl = new TCCCCommonCallback(@"checkLogin");
    }
    // 判断是否已登录
    tcccSDK->checkLogin(checkLoginCallbackImpl);
}

- (void)logoutButtonTapped:(UIButton *)sender {
    if (nullptr == logoutCallbackImpl) {
        logoutCallbackImpl = new TCCCCommonCallback(@"logout");
    }
    // 退出登录
    tcccSDK->logout(logoutCallbackImpl);
}

- (void)startCallButtonTapped:(UIButton *)sender {
    if (nullptr == startCallCallbackImpl) {
        startCallCallbackImpl = new TCCCCommonCallback(@"startCall");
    }
    TCCCStartCallParams callParams;
    callParams.to = [TO UTF8String];
    callParams.uui = "\n{xxx:\r\nxxxx\n}中国01 xxx02*-`";
    callParams.remark ="testByIos";
    tcccSDK->call(callParams, startCallCallbackImpl);
}

- (void)muteButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.muteButton setTitle:@"静音" forState:UIControlStateNormal];
}

- (void)hangupButtonTapped:(UIButton *)sender {
    // 终止会话
    tcccSDK->terminate();
}

- (void)speakerButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.speakerButton setTitle:@"扬声器" forState:UIControlStateNormal];
    
}


@end
