
## API 概览
### 创建实例和事件回调
| API | 描述 |
|-----|-----|
| [getTCCCShareInstance](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a5f9c01b6f320d73299a8794fd1b113c2) | 创建 ITCCCWorkstation 实例（单例模式） |
| [destroyTCCCShareInstance](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a291fad1a867e90296c28921c814abb96) | 销毁 ITCCCWorkstation 实例（单例模式）  |
| [addCallback](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#aed44903d7d6bac8b95754071e6e03d92) | 添加 ITCCCWorkstation 事件回调 |
| [removeCallback](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a129572ebab88dae9f4779df3da5c844a) | 移除 ITCCCWorkstation 事件回调 |

#### 创建实例和设置事件回调示例代码
```c++
#include "tccc/include/ITCCCWorkstation.h"
using namespace tccc;
// 创建实例和设置事件回调
ITCCCWorkstation* tcccSDK = getTCCCShareInstance();
// 设置回调，TCCCCallbackImpl 需要继承 ITCCCCallback
class TCCCCallbackImpl:public ITCCCCallback {
public:
    TCCCCallbackImpl() {}
    ~TCCCCallbackImpl() {}

    void onError(TCCCError errCode, const char* errMsg, void* extraInfo) {}
    
    void onWarning(TCCCCWarning warningCode, const char* warningMsg, void* extraInfo) {}

    void onNewSession(TCCCSessionInfo info) {}

    void onEnded(EndedReason reason, const char* reasonMessage, const char* sessionId) {}
    
};
TCCCCallbackImpl* tcccCallback = new TCCCCallbackImpl();
tcccSDK->addCallback(tcccCallback);
// 销毁实例
destroyTCCCShareInstance();
tcccSDK = nullptr;
```

### 登录相关接口函数
| API | 描述 |
|-----|-----|
| [login](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#ac2e2626582978763ba1731335a2361da) | SDK 登录 |
| [checkLogin](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#ac2e2626582978763ba1731335a2361da) | 检查 SDK 是否已登录 |
| [logout](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#af57dce6ebc48d6dbd47c68c0efbb3377) | SDK 退出登录 |

#### 登录示例代码
```c++
// 登录回调类
class TCCCLoginCallbackImpl : public ITXValueCallback<TCCCLoginInfo> {
public:
    TCCCLoginCallbackImpl() {
        
    }
    ~TCCCLoginCallbackImpl() override {}
    void OnSuccess(const TCCCLoginInfo &value) override {
        // 登录成功
    }
    
    void OnError(TCCCError error_code, const char *error_message) override {
        // 登录失败
    }
};
TCCCLoginCallbackImpl* loginCallBackImpl = nullptr;
if (nullptr == loginCallBackImpl) {
  loginCallBackImpl = new TCCCLoginCallbackImpl();
}
TCCCLoginParams param;
/// 登录的坐席ID，通常为邮箱地址
param.userId = "";
/// 登录票据，在登录模式为Agent必填。更多详情请参见[创建 SDK 登录
/// Token](https://cloud.tencent.com/document/product/679/49227)
param.token = "";
/// 腾讯云联络中心应用ID，通常为1400开头
param.sdkAppId = 0;
// 必须知道为坐席模式
param.type = TCCCLoginType::Agent;
// 登录
tcccSDK->login(param,loginCallBackImpl);
// 退出登录
tcccSDK->logout(nullptr);
```

### 呼叫相关接口函数
| API | 描述 |
|-----|-----|
| [call](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a44131b3f2307f59e84e8dc2547284468) | 发起通话 |
| [answer](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#afb05a94c75ae0fdf80b400a560f90382) | 接听来电 |
| [terminate ](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#ad246edc074358e8db219f524240c2e0e) | 结束通话 |
| [sendDTMF](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a759c3add9cca0c158d8b76ddaf158b53) | 发送 DTMF（双音多频信号）|
| [mute](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a2dad8c4fa7358a119203920194cc1983) | 静音 |
| [unmute](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a154949474d50c76412757cbc9fb57ea1) | 取消静音 |
#### 发起呼叫和结束呼叫示例代码
```c++
class TCCCCommonCallback : public ITXCallback {
private:
    NSString* mFunName;
public:
    TCCCCommonCallback(NSString* funName) {
        mFunName = funName;
    }
    ~TCCCCommonCallback() override {
        
    }
    void OnSuccess() override {
      // 成功
    }
    
    void OnError(TCCCError error_code, const char *error_message) override {
        std::string copyErrMsg = makeString(error_message);
      // 失败
    }
};
TCCCCommonCallback* startCallCallbackImpl = nullptr;
if (nullptr == startCallCallbackImpl) {
  startCallCallbackImpl = new TCCCCommonCallback(@"startCall");
}
TCCCStartCallParams callParams;
//呼叫的手机号
callParams.to = "";
// 发起外呼
tcccSDK->call(callParams, startCallCallbackImpl);
// 结束通话
tcccSDK->terminate();
```


### 音频设备接口函数
| API | 描述 |
|-----|-----|
| [setAudioCaptureVolume](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_device_manager.html#a660142406f9e3aa19fae45b9a94f009b) | 设定本地音频的采集音量 |
| [getAudioCaptureVolume](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_device_manager.html#a0162ef11f33bcbb90bf7effd4f5bfde9) | 获取本地音频的采集音量 |
| [setAudioPlayoutVolume](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_device_manager.html#ada5d60cce32407134b3cbef4cec01e7d) | 设定远端音频的播放音量 |
| [getAudioPlayoutVolume](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_device_manager.html#ae22d9e1dff2e2c7184d40428cd94e1bd) | 获取远端音频的播放音量 |
| [setAudioRoute](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#af6fc1a15608fdaebc0dec7cc006ba441) | 设置音频路由 |


### 调试相关接口
| API | 描述 |
|-----|-----|
| [getSDKVersion](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#adce46ac2533271abbe5fd1c9e2b5b269) | 获取 SDK 版本信息 |
| [setLogLevel](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#adc38b8e5f7c7bbb52913133a09c660c3) | 设置 Log 输出级别 |
| [setConsoleEnabled](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#ac96dc3ba8d3ee4415cdbdc66cd604526) | 启用/禁用控制台日志打印 |
| [callExperimentalAPI](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_workstation.html#a5496b58b1c9c5300ae10414d4a7f9222) | 调用实验性接口 |

#### 获取SDK版本示例代码
```c++
// 获取SDK 版本号
tcccSDK->getSDKVersion();
```


### 错误和警告事件
| API | 描述 |
|-----|-----|
| [onError](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a91194f813d01fb57815d779098de8ed5) | 错误事件回调 |
| [onWarning](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a5262b33074879d9e833c29a97ee42c14) | 警告事件回调 |

#### 处理错误回调事件回调示例代码
```c++
// 设置回调，TCCCCallbackImpl 需要继承 ITCCCCallback
class TCCCCallbackImpl:public ITCCCCallback {
public:
    TCCCCallbackImpl() {}
    ~TCCCCallbackImpl() {}
    // 错误事件回调
    void onError(TCCCError errCode, const char* errMsg, void* extraInfo) {}
    // 警告事件回调
    void onWarning(TCCCCWarning warningCode, const char* warningMsg, void* extraInfo) {}
};
TCCCCallbackImpl* tcccCallback = new TCCCCallbackImpl();
tcccSDK->addCallback(tcccCallback);
```

### 呼叫相关事件回调
| API | 描述 |
|-----|-----|
| [onNewSession](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a4f86c49ff5a05dbb25e1a102e11608f5) | 新会话事件。包括呼入和呼出 |
| [onEnded](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a7429f478a0bb871d2d31e74ad423cd07) | 会话结束事件 |
| [onAudioVolume](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#afcfe494e91225992c91e8569cf4e7b4c) | 音量大小的反馈回调 |
| [onNetworkQuality ](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a63ccb82554e524240d318e8df9f2c1ca) | 网络质量的实时统计回调 |

#### 处理接听和坐席挂断事件回调示例代码

```c++
// 设置回调，TCCCCallbackImpl 需要继承 ITCCCCallback
class TCCCCallbackImpl:public ITCCCCallback {
public:
    TCCCCallbackImpl() {}
    ~TCCCCallbackImpl() {}
    // 新会话事件。包括呼入和呼出
    void onNewSession(TCCCSessionInfo info) {}
    // 会话结束事件
    void onEnded(EndedReason reason, const char* reasonMessage, const char* sessionId) {}
    
};
TCCCCallbackImpl* tcccCallback = new TCCCCallbackImpl();
tcccSDK->addCallback(tcccCallback);
```


### 与云端连接情况的事件回调
| API | 描述 |
|-----|-----|
| [onConnectionLost](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#ad80d24863ae3906e96809d5caa26d392) | SDK 与云端的连接已经断开 |
| [onTryToReconnect](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#abafd1254e57eda469ae04c7073227752) | SDK 正在尝试重新连接到云端 |
| [onConnectionRecovery](https://tccc.qcloud.com//assets/doc/Agent/CppAPI/classtccc_1_1_i_t_c_c_c_callback.html#a881626fcdb9468c7a00a7419f5e1dc40) | SDK 与云端的连接已经恢复 |

#### 与云端连接情况的事件回调示例代码

```c++
// 设置回调，TCCCCallbackImpl 需要继承 ITCCCCallback
class TCCCCallbackImpl:public ITCCCCallback {
public:
    TCCCCallbackImpl() {}
    ~TCCCCallbackImpl() {}
    // SDK 与云端的连接已经断开
    void onConnectionLost(TCCCServerType serverType) {}
    // SDK 正在尝试重新连接到云端
    void onTryToReconnect(TCCCServerType serverType) {}
    // SDK 与云端的连接已经恢复
    void onConnectionRecovery(TCCCServerType serverType) {}
};
TCCCCallbackImpl* tcccCallback = new TCCCCallbackImpl();
tcccSDK->addCallback(tcccCallback);
```



## API 错误码
### 基础错误码

| 符号 | 值 | 含义 |
|---|---|---|
|ERR_SIP_SUCCESS|200|成功|
|ERR_UNRIGIST_FAILURE|20001|登录失败|
|ERR_ANSWER_FAILURE|20002|接听失败，通常是trtc进房失败|
|ERR_SIPURI_WRONGFORMAT|20003|URI 格式错误。|
|ERR_HTTP_REQUEST_FAILURE|-10001|Http 请求失败，请检查网络连接情况|
|ERR_HTTP_TOKEN_ERROR|-10002|token登录票据不正确或者已过期|
|ERR_HTTP_GETSIPINFO_ERROR|-10003|获取坐席配置失败。请联系我们|

### SIP相关错误码

| 符号 | 值 | 含义 |
|---|---|---|
|ERR_SIP_BAD_REQUEST|400|错误请求|
|ERR_SIP_UNAUTHORIZED|401|未授权（用户名密码不对情况）|
|ERR_SIP_AUTHENTICATION_REQUIRED|407|代理需要认证，请检查是否已经调用登录接口|
|ERR_SIP_REQUESTTIMEOUT|408|请求超时（网络超时）|
|ERR_SIP_REQUEST_TERMINATED|487|请求终止（网络异常，网络中断场景下）|
|ERR_SIP_SERVICE_UNAVAILABLE|503|服务不可用|
|ERR_SIP_SERVER_TIMEOUT|504|服务超时|


### 音频设备相关错误码
| 符号 | 值 | 含义 |
|---|---|---|
|ERR_MIC_START_FAIL|-1302|打开麦克风失败。设备，麦克风的配置程序（驱动程序）异常，禁用后重新启用设备，或者重启机器，或者更新配置程序|
|ERR_MIC_NOT_AUTHORIZED|-1317|麦克风设备未授权，通常在移动设备出现，可能是权限被用户拒绝了|
|ERR_MIC_SET_PARAM_FAIL|-1318|麦克风设置参数失败|
|ERR_MIC_OCCUPY|-1319|麦克风正在被占用中，例如移动设备正在通话时，打开麦克风会失败|
|ERR_MIC_STOP_FAIL|-1320|停止麦克风失败|
|ERR_SPEAKER_START_FAIL|-1321|打开扬声器失败，例如在 Windows 或 Mac|
|ERR_SPEAKER_SET_PARAM_FAIL|-1322|扬声器设置参数失败|
|ERR_SPEAKER_STOP_FAIL|-1323|停止扬声器失败|
|ERR_UNSUPPORTED_SAMPLERATE|-1306|不支持的音频采样率|

### 网络相关错误码
| 符号 | 值 | 含义 |
|---|---|---|
|ERR_RTC_ENTER_ROOM_FAILED|-3301|进入房间失败，请查看 onError 中的 -3301 对应的 msg 提示确认失败原因|
|ERR_RTC_REQUEST_IP_TIMEOUT|-3307|请求 IP 和 sig 超时，请检查网络是否正常，或网络防火墙是否放行 UDP。|
|ERR_RTC_CONNECT_SERVER_TIMEOUT|-3308|请求进房超时，请检查是否断网或者是否开启vpn，您也可以切换4G进行测试确认|
|ERR_RTC_ENTER_ROOM_REFUSED|-3340|进房请求被拒绝，请检查是否连续调用 enterRoom 进入相同 Id 的房间|