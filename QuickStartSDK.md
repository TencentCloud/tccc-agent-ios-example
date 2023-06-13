# 快速集成腾讯云呼叫中心 ios Agent SDK

    本文主要介绍如何快速地将腾讯云呼叫中心 ios Agent SDK 集成到您的项目中，只要按照如下步骤进行配置，就可以完成 SDK 的集成工作。

## 开发环境要求

- Xcode 9.0+。 
- iOS 9.0 以上的 iPhone 或者 iPad 真机。
- 项目已配置有效的开发者签名。


## 集成 SDK

### 手动下载
    目前我们暂时还未发布到 CocoaPods ，您只能手动下载 SDK 集成到工程里：

1. 下载最新版本 [TCCC Agent SDK](https://tccc.qcloud.com/assets/doc/Agent/CppSDKRelease/TCCCSDK_ios_last.zip)。

2. 打开您的 Xcode 工程项目，选择要运行的 target , 选中 **Build Phases** 项。

![](https://qcloudimg.tencent-cloud.cn/raw/81a5cddcb55a6f96d34b07e6ee267f98.jpg)

3. 单击 Link Binary with Libraries 项展开，单击底下的“+”号图标去添加依赖库。

![](https://qcloudimg.tencent-cloud.cn/raw/c50b4d1df77772003512e6c3cde2fffb.png)

4. 依次添加下载的 **TCCCSDK.Framework**、**TXFFmpeg.xcframework**、**TXSoundTouch.xcframework**、及其所需依赖库 **GLKit.framework**、**AssetsLibrary.framework**、**SystemConfiguration.framework**、**libsqlite3.0.tbd**、**CoreTelephony.framework**、**AVFoundation.framework**、**OpenGLES.framework**、**Accelerate.framework**、**MetalKit.framework**、**libresolv.tbd**、**MobileCoreServices.framework**、**libc++.tbd**、**CoreMedia.framework**。

![](https://qcloudimg.tencent-cloud.cn/raw/1bc89e71916a5dd9aa3623e36060df40.png)

5. 单击 General，选择 **Frameworks,Libraries,and Embedded Content**，检查 **TCCCSDK.framework** 所需要动态库 **TXFFmpeg.xcframework**、**TXSoundTouch.xcframework**是否已经添加，是否正确选择选择 Embed & Sign，如果没有单击底下的“**+**”号图标依次添加。

![](https://qcloudimg.tencent-cloud.cn/raw/7c43561cfa553af5e52492ff9fe3299a.png)

6. 在工程target中Build Settings的**Other Linker Flags**增加-ObjC配置。

![](https://qcloudimg.tencent-cloud.cn/raw/6a258480162aef4ca3626c388999bb9f.png)

7. 配置 **Header Search Paths**。如下类似输入

![](https://qcloudimg.tencent-cloud.cn/raw/791b37dad9ab9c86b7a7d63a1256211a.png)

```
$(PROJECT_DIR)/tccc-agent-ios-example/framework/TCCCSDK.framework/Headers
```


## 配置 App 权限
1. 如需使用 SDK 提供的音视频功能，需要给 App 授权麦克风的使用权限。在 App 的 Info.plist 中添加以下两项，分别对应麦克风在系统弹出授权对话框时的提示信息。

  ![](https://qcloudimg.tencent-cloud.cn/raw/35f2cfb2dfd2dbf4bac4d90a076e8473.png)

  - Privacy - Microphone Usage Description，并填入麦克风使用目的提示语。


2. 如需 App 进入后台仍然运行相关功能，可在 XCode 中选中当前工程项目，并在 Capabilities 下将设置项  Background Modes 设定为 ON，并勾选 Audio，AirPlay and Picture in Picture ，如下图所示：

![](https://qcloudimg.tencent-cloud.cn/raw/206506cefe3957d482f9a89fa06ce068.png)


## 代码实现

目前我们只提供了通过 C++ 接口，可以用下面代码引入头文件

```c++
// 引入C++头文件
#include "tccc/include/ITCCCWorkstation.h"
// 使用tccc命名空间
using namespace tccc;
// 获取tcccSDK 单例
ITCCCWorkstation* tcccSDK = getTCCCShareInstance();
// 获取SDK版本号
const char *  version = tcccSDK->getSDKVersion();

```

具体编码实现可参考 [API 概览以及示例](api.md)

## 常见问题

###  如何查看 TCCC 日志？

TCCC 的日志默认压缩加密，后缀为 .log。
- ios：
	- 日志路径：**sandbox/Documents/tccc** 

### 在ios下回调是否都在主线程
目前在ios下回调都不在主线程，需要业务层面上判断并且把他转为主线线程
```oc
if ([NSThread isMainThread]) {
    // 在主线程，直接可以处理
    return;
}
dispatch_async(dispatch_get_main_queue(), ^{
    // 回调在非主线程。
});
```

### 发起呼叫报 408 或者 503 错误，如何处理？

这种情况一般出现在应用程序切后台重新唤醒后，网络状态还未完全恢复。我们强烈建议您在发起呼叫或者是程序切回前台的时候调用接口判断是否是已登录。

```cpp
class TCCCCommonCallback : public ITXCallback {
public:
    TCCCCommonCallback() {
    }
    ~TCCCCommonCallback() override {
        
    }
    void OnSuccess() override {
    }
    
    void OnError(TCCCError error_code, const char *error_message) override {
        // 登录异常，提醒用户，并且重新登陆。
        if (code == 408 || code==503) {
            // 网络还未恢复，重置网络。
            tcccSDK->resetSip(false);
        }
    }
};
TCCCCommonCallback* checkLoginCB = new TCCCCommonCallback();
// 检查登录状态
tcccSDK->checkLogin(checkLoginCB);
```

