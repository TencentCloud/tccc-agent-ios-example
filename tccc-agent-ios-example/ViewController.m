//
//  ViewController.m
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2024/3/19.
//

#import "ViewController.h"
#import "Debug/GenerateTestUserToken.h"
#import "TCCCSDK/tccc/platform/apple/TCCCWorkstation.h"

@interface ViewController ()<TCCCDelegate>

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

@property (nonatomic, strong) UITextView *logView;
@property (nonatomic, strong) UIButton *clearLogsButton;

@property (strong, nonatomic) TCCCWorkstation *tcccSDK;

@end

@implementation ViewController

// 获取tcccSDK 单例
- (TCCCWorkstation*)tcccSDK {
    if (!_tcccSDK) {
        // 创建实例
        _tcccSDK = [TCCCWorkstation sharedInstance];
    }
    return _tcccSDK;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initTcccSDK];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 移除TCCC事件回调
    [self.tcccSDK removeTCCCListener:self];
    // 销毁实例
    [TCCCWorkstation destroySharedIntance];
    _tcccSDK = nil;
}

- (void)initUI {
    CGFloat screenWidth = CGRectGetWidth(self.view.bounds);
    CGFloat screenHeight = CGRectGetHeight(self.view.bounds);
    
    // 创建UserId输入框
    self.seatUserIdField = [[UITextField alloc] initWithFrame:CGRectMake(20, 60, self.view.bounds.size.width - 40, 40)];
    self.seatUserIdField.placeholder = @"please enter user name";
    self.seatUserIdField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.seatUserIdField];
    self.seatUserIdField.text = USERID;
    
    // create token input
    self.tokenField = [[UITextField alloc] initWithFrame:CGRectMake(20, 110, self.view.bounds.size.width - 40, 40)];
    self.tokenField.placeholder = @"please enter token(Click the Get Token button)";
    self.tokenField.borderStyle = UITextBorderStyleRoundedRect;
    self.tokenField.secureTextEntry = YES;
    [self.view addSubview:self.tokenField];
    
    // create get token button
    self.getTokenButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.getTokenButton.frame = CGRectMake(20, 150, 80, 40);
    [self.getTokenButton setTitle:@"Get Token" forState:UIControlStateNormal];
    [self.getTokenButton addTarget:self action:@selector(getTokenButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getTokenButton];
    
    // create login button
    self.loginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.loginButton.frame = CGRectMake(85, 150, 80, 40);
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButton];
    
    self.isLoginButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.isLoginButton.frame = CGRectMake(150, 150, 95, 40);
    [self.isLoginButton setTitle:@"Check Login" forState:UIControlStateNormal];
    [self.isLoginButton addTarget:self action:@selector(isLogoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.isLoginButton];
    
    // create logout button
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.logoutButton.frame = CGRectMake(240, 150, 80, 40);
    [self.logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(logoutButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logoutButton];
    
    // create call button
    self.startCallButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.startCallButton.frame = CGRectMake(15, 180, 50, 50);
    [self.startCallButton setTitle:@"Call" forState:UIControlStateNormal];
    [self.startCallButton addTarget:self action:@selector(startCallButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.startCallButton];
    
    // create hang up button
    self.hangupButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.hangupButton.frame = CGRectMake(60, 180, 80, 50);
    [self.hangupButton setTitle:@"Hang Up" forState:UIControlStateNormal];
    [self.hangupButton addTarget:self action:@selector(hangupButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.hangupButton];
    
    // create mute button
    self.muteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.muteButton.frame = CGRectMake(20, 215, 50, 50);
    [self.muteButton setTitle:@"Mute" forState:UIControlStateNormal];
    [self.muteButton addTarget:self action:@selector(muteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.muteButton];
    
    // create Speaker button
    self.speakerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.speakerButton.frame = CGRectMake(60, 215, 90, 50);
    [self.speakerButton setTitle:@"Speaker" forState:UIControlStateNormal];
    [self.speakerButton addTarget:self action:@selector(speakerButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.speakerButton];
    
    // create clear logs button
    self.clearLogsButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.clearLogsButton.frame = CGRectMake(155, 215, 90, 50);
    [self.clearLogsButton setTitle:@"Clear Logs" forState:UIControlStateNormal];
    [self.clearLogsButton addTarget:self action:@selector(clearLogsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.clearLogsButton];
    
    self.logView = [[UITextView alloc] initWithFrame:CGRectMake(10, 265, screenWidth - 20, screenHeight/2 + 90)];
    self.logView.textAlignment = NSTextAlignmentLeft;
    self.logView.font = [UIFont systemFontOfSize:12];
    self.logView.editable = false;
    self.logView.backgroundColor = [UIColor blackColor];
    self.logView.textColor = [UIColor whiteColor];
    self.logView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.logView.text = @"Logs:";
    [self.view addSubview:self.logView];
}

- (void)initTcccSDK {
    // 获取SDK版本号
    NSString* version = [TCCCWorkstation getSDKVersion];
    [self writeFunCallLog:[NSString stringWithFormat:@"tccc SDK version: %@", version]];
    // 设置TCCC事件回调
    [self.tcccSDK addTcccListener:self];
}

- (void)getTokenButtonTapped:(UIButton *)sender {
    [self writeFunCallLog:[NSString stringWithFormat:@"genTestUserToken,userId= %@", self.seatUserIdField.text]];
    self.getTokenButton.selected = true;
    // 获取token
    [GenerateTestUserToken genTestUserToken:self.seatUserIdField.text completion:^(NSString *token, NSError *error) {
        self.getTokenButton.selected = false;
        if (error) {
            [self writeCallBackLog:[NSString stringWithFormat:@"genTestUserToken error,errorMessage= %@", error.localizedDescription]];
        } else {
            self.tokenField.text = token;
            [self writeCallBackLog:[NSString stringWithFormat:@"genTestUserToken success,token= %@", token]];
        }
    }];
}

- (void)loginButtonTapped:(UIButton *)sender {
    TXLoginParams *param = [[TXLoginParams alloc] init];
    // 登录的坐席ID，通常为邮箱地址
    param.userId = self.seatUserIdField.text;
    // 登录票据，在登录模式为Agent必填。更多详情请参见[创建 SDK 登录
    // Token](https://cloud.tencent.com/document/product/679/49227)
    param.token = self.tokenField.text;
    // 腾讯云联络中心应用ID，通常为1400开头
    param.sdkAppId = SDKAppID;
    // 设置为坐席模式
    param.type =  Agent;
    [self writeFunCallLog:[NSString stringWithFormat:@"[tcccSDK login] userId= %@", param.userId]];
    [self.tcccSDK login:param succ:^(TXLoginInfo * _Nonnull info) {
        [self writeCallBackLog:[NSString stringWithFormat:@"login Success , userId=%@", info.userId]];
    } fail:^(int code, NSString * _Nonnull desc) {
        [self writeCallBackLog:[NSString stringWithFormat:@"login Error , errCode=%d , errMsg=%@",code,desc]];
    }];
}

- (void)isLogoutButtonTapped:(UIButton *)sender {
    [self writeFunCallLog:@"[tcccSDK checkLogin]"];
    [self.tcccSDK checkLogin:^{
        [self writeCallBackLog:@"checkLogin success"];
    } fail:^(int code, NSString * _Nonnull desc) {
        [self writeCallBackLog:[NSString stringWithFormat:@"checkLogin Error , errCode=%d , errMsg=%@",code,desc]];
    }];
}

- (void)logoutButtonTapped:(UIButton *)sender {
    [self writeFunCallLog:@"[tcccSDK logout]"];
    [self.tcccSDK logout:^{
        [self writeCallBackLog:@"logout success"];
    } fail:^(int code, NSString * _Nonnull desc) {
        [self writeCallBackLog:[NSString stringWithFormat:@"logout Error , errCode=%d , errMsg=%@",code,desc]];
    }];
}

- (void)startCallButtonTapped:(UIButton *)sender {
    TXStartCallParams *callParams = [[TXStartCallParams alloc] init];
    // 呼叫的手机号
    callParams.to = TO;
    // 号码备注，在通话条中会替代号码显示（可选）
    callParams.remark = @"testByIos";
    [self writeFunCallLog:[NSString stringWithFormat:@"[tcccSDK call] to= %@", callParams.to]];
    // 发起外呼
    [self.tcccSDK call:callParams succ:^{
        [self writeCallBackLog:@"call success"];
    } fail:^(int code, NSString * _Nonnull desc) {
        [self writeCallBackLog:[NSString stringWithFormat:@"call Error , errCode=%d , errMsg=%@",code,desc]];
    }];
}

- (void)muteButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.muteButton setTitle:@"Mute" forState:UIControlStateNormal];
    [self writeFunCallLog:@"[tcccSDK mute]"];
    // 静音
    [self.tcccSDK mute];
}

- (void)hangupButtonTapped:(UIButton *)sender {
    [self writeFunCallLog:@"[tcccSDK terminate]"];
    // 结束通话
    [self.tcccSDK terminate];
}

- (void)speakerButtonTapped:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.speakerButton setTitle:@"Speaker" forState:UIControlStateNormal];
    [self writeFunCallLog:@"[[tcccSDK getDeviceManager()] setAudioRoute] ,TCCCAudioRouteSpeakerphone"];
    // 切换为扬声器
    [[self.tcccSDK getDeviceManager] setAudioRoute:TCCCAudioRouteSpeakerphone];
}

- (void)clearLogsButtonTapped:(UIButton *)sender {
    self.logView.text = @"Logs:";
    [self writeFunCallLog:@"clear log"];
}

- (void)writeFunCallLog:(NSString *)line {
    NSString *appendedText = [NSString stringWithFormat:@"%@\n ==> %@", self.logView.text,line];
    NSLog(@"%@", appendedText);
    self.logView.text = appendedText;
}

- (void)writeCallBackLog:(NSString *)line {
    NSString *appendedText = [NSString stringWithFormat:@"%@\n <== %@", self.logView.text,line];
    NSLog(@"%@", appendedText);
    self.logView.text = appendedText;
}

- (void)exampleCode {
    // 检查登录状态
    [self.tcccSDK checkLogin:^{
        // 已登录
    } fail:^(int code, NSString * _Nonnull desc) {
        // 未登录或者被T了
    }];
    // 退出登录
    [self.tcccSDK logout:^{
        // 退出成功
    } fail:^(int code, NSString * _Nonnull desc) {
        // 退出异常
    }];
    // 接听来电
    [self.tcccSDK answer:^{
        // 接听成功
    } fail:^(int code, NSString * _Nonnull desc) {
        // 接听失败
    }];
}

#pragma mark - TCCCDelegate

- (void)onError:(TCCCErrorCode)errCode errMsg:(NSString * _Nonnull)errMsg extInfo:(nullable NSDictionary *)extInfo {
    [self writeCallBackLog:[NSString stringWithFormat:@"onError errorCode=%ld,errorMessage=%@", (long)errCode,errMsg]];
}

- (void)onWarning:(TCCCCWarningCode)warningCode warningMsg:(NSString *_Nonnull)warningMsg extInfo:(nullable NSDictionary *)extInfo {
    [self writeCallBackLog:[NSString stringWithFormat:@"onWarning warningMsg=%ld,warningMsg=%@", (long)warningCode,warningMsg]];
}

- (void)onNewSession:(TXSessionInfo *)info {
    [self writeCallBackLog:[NSString stringWithFormat:@"onNewSession sessionDirection=%ld, fromUserID=%@ ,sessionID=%@",info.sessionDirection, info.fromUserID,info.sessionID]];
}

- (void)onEnded:(TXEndedReason)reason reasonMessage:(NSString *_Nonnull)reasonMessage sessionId:(NSString *_Nonnull)sessionId {
    [self writeCallBackLog:[NSString stringWithFormat:@"onEnded reason=%ld,reasonMessage=%@  , sessionId=%@", (long)reason,reasonMessage,sessionId]];
}

- (void)onAccepted:(NSString *_Nonnull)sessionId {
    [self writeCallBackLog:[NSString stringWithFormat:@"onAccepted , sessionId=%@",sessionId]];
}

- (void)onConnectionLost:(TXServerType)serverType {
    [self writeCallBackLog:[NSString stringWithFormat:@"onConnectionLost , serverType=%ld",(long)serverType]];
}

- (void)onTryToReconnect:(TXServerType)serverType {
    [self writeCallBackLog:[NSString stringWithFormat:@"onTryToReconnect , serverType=%ld",(long)serverType]];
}

- (void)onConnectionRecovery:(TXServerType)serverType {
    [self writeCallBackLog:[NSString stringWithFormat:@"onConnectionRecovery , serverType=%ld",(long)serverType]];
}

@end
