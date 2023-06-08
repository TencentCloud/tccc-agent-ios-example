# 快速集成腾讯云呼叫中心 ios SDK

    本文主要介绍如何快速地将腾讯云呼叫中心 ios SDK 集成到您的项目中，只要按照如下步骤进行配置，就可以完成 SDK 的集成工作。

## 开发环境要求

- Xcode 9.0+。 
- iOS 9.0 以上的 iPhone 或者 iPad 真机。
- 项目已配置有效的开发者签名。


## 集成 SDK

### 手动下载
    目前我们暂时还未发布到 CocoaPods ，您只能手动下载 SDK 集成到工程里：

1. 下载最新版本 [TCCC Agent SDK](https://tccc.qcloud.com/assets/doc/Agent/CppSDKRelease/TCCCSDK_ios_last.zip)。

2. 打开您的 Xcode 工程项目，选择要运行的 target , 选中 **Build Phases** 项。

![]()

3. 单击 Link Binary with Libraries 项展开，单击底下的“+”号图标去添加依赖库。

![]()

4. 依次添加下载的 **TCCCSDK.Framework**、**TXFFmpeg.xcframework**、**TXSoundTouch.xcframework**、及其所需依赖库 **GLKit.framework**、**AssetsLibrary.framework**、**SystemConfiguration.framework**、**libsqlite3.0.tbd**、**CoreTelephony.framework**、**AVFoundation.framework**、**OpenGLES.framework**、**Accelerate.framework**、**MetalKit.framework**、**libresolv.tbd**、**MobileCoreServices.framework**、**libc++.tbd**、**CoreMedia.framework**。

![]()

5. 单击 General，选择 **Frameworks,Libraries,and Embedded Content**，检查 **TCCCSDK.framework** 所需要动态库 **TXFFmpeg.xcframework**、**TXSoundTouch.xcframework**是否已经添加，是否正确选择选择 Embed & Sign，如果没有单击底下的“**+**”号图标依次添加。

![]()

6. 在工程target中Build Settings的Other Linker Flags增加-ObjC配置。

7. 配置 Header Search Paths
```
$(PROJECT_DIR)/tccc-agent-ios-example/framework/TCCCSDK.framework/Headers
```

## 配置 App 权限
1. 如需使用 SDK 提供的音视频功能，需要给 App 授权麦克风的使用权限。在 App 的 Info.plist 中添加以下两项，分别对应麦克风在系统弹出授权对话框时的提示信息。
  - Privacy - Microphone Usage Description，并填入麦克风使用目的提示语。

![]()


2. 如需 App 进入后台仍然运行相关功能，可在 XCode 中选中当前工程项目，并在 Capabilities 下将设置项  Background Modes 设定为 ON，并勾选 Audio，AirPlay and Picture in Picture ，如下图所示：

![]()



## 代码实现

具体编码实现可参考 [API 概览以及示例](api.md)

## 常见问题

###  如何查看 TCCC 日志？

TCCC 的日志默认压缩加密，后缀为 .log。
- ios：
	- 日志路径：**sandbox/Documents/tccc** 


### 发起呼叫报 408 或者 503 错误，如何处理？

这种情况一般出现在应用程序切后台重新唤醒后，网络状态还未完全恢复。我们强烈建议您在发起呼叫或者是程序切回前台的时候调用接口判断是否是已登录。

```cpp
// 检查登录状态
tcccSDK->checkLogin(new TXCallback() {
    @Override
    public void onSuccess() {
        // 已登录成功
    }

    @Override
    public void onError(int code, String message) {
        // 登录异常，提醒用户，并且重新登陆。
        if (code == 408 || code==503) {
            // 网络还未恢复，重置网络。
            tcccSDK.resetSip(false);
        }
    }
});
```
