## 集成云联络中心 iOS Agent SDK

 本文主要介绍如何快速地将腾讯云联络中心 iOS Agent SDK 集成到您的项目中，只要按照如下步骤进行配置，就可以完成 SDK 的集成工作。

## 开发环境要求
- Xcode 9.0+。 

- iOS 9.0 以上的 iPhone 或者 iPad 真机。

- 项目已配置有效的开发者签名。


## 集成 SDK

### 方案1：使用 CocoaPods
1. 安装 CocoaPods
在终端窗口中输入如下命令（需要提前在 Mac 中安装 Ruby 环境）：

   ``` bash
   sudo gem install cocoapods
   ```
2. 创建 Podfile 文件
进入项目所在路径，输入以下命令行之后项目路径下会出现一个 Podfile 文件。

   ``` bash
   pod init
   ```
3. 编辑 Podfile 文件
根据您的项目需要编辑 Podfile 文件：

   ``` bash
    platform :ios, '11.0'
   
     target 'App' do
       pod 'TCCCSDK_Ios', :podspec => 'https://tccc.qcloud.com/assets/doc/Agent/CppSDKRelease/TCCCSDK_Ios.podspec'
     end
   ```
4. 更新并安装 SDK

  - 在终端窗口中输入如下命令以更新本地库文件，并安装 SDK：

      ``` bash
      pod install
      ```
  - 或使用以下命令更新本地库版本：

      ``` bash
      pod update
      ```

      pod 命令执行完后，会生成集成了 SDK 的 .xcworkspace 后缀的工程文件，双击打开即可。


### 方案2：手动下载
1. 下载最新版本 [TCCC Agent SDK](https://tccc.qcloud.com/assets/doc/Agent/CppSDKRelease/TCCCSDK_ios_last.zip)。

2. 打开您的 Xcode 工程项目，选择要运行的 target ，单击 **Build Phases** 项。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/e00623c1cac1061c93937247b23595bb.jpeg)

3. 单击** Link Binary with Libraries** 项展开，单击底下的“**+**”号图标去添加依赖库。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/c5433a2432a138269a629bd23309f789.png)

4. 依次添加下载的 **TCCCSDK.Framework**、**TXFFmpeg.xcframework**、**TXSoundTouch.xcframework，**及其所需依赖库 **GLKit.framework**、**AssetsLibrary.framework**、**SystemConfiguration.framework**、**libsqlite3.0.tbd**、**CoreTelephony.framework**、**AVFoundation.framework**、**OpenGLES.framework**、**Accelerate.framework**、**MetalKit.framework**、**libresolv.tbd**、**MobileCoreServices.framework**、**libc++.tbd**、**CoreMedia.framework**。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/86787174ea1baff04ab2ede618fed611.png)

5. 单击 **General**，选择 **Frameworks**，**Libraries**，**and Embedded Content**，检查 **TCCCSDK.framework** 所需要动态库 **TXFFmpeg.xcframework**、**TXSoundTouch.xcframework **是否已经添加，是否正确选择 Embed & Sign，如果没有单击底下的 “**+**” 号图标依次添加。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/16e90f50a417e687e95024465bce9fc1.png)

6. 在工程 target 中 Build Settings 的 **Other Linker Flags **增加 -ObjC 配置。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/1700c039b2b761993b3b5e6ec567dd0b.png)


## 配置 App 权限
1. 如需使用 SDK 提供的音视频功能，需要给 App 授权麦克风的使用权限。在 App 的 Info.plist 中添加对应麦克风在系统弹出授权对话框时的提示信息。

   ![](https://qcloudimg.tencent-cloud.cn/image/document/761ba2de887466f014d4549556911c64.png)

2. 如需 App 进入后台仍然运行相关功能，可在 XCode 中选中当前工程项目，并在 Capabilities 下将设置项  Background Modes 设定为 ON，并勾选 Audio，AirPlay and Picture in Picture ，如下图所示：

   ![](https://qcloudimg.tencent-cloud.cn/image/document/36bed7bc569e00691bbead514036dc6a.png)


## 代码实现

目前我们提供了 Swift、OC、C++ 接口供开发者选择使用，可以用下面代码引入头文件：

- Swift代码示例
``` swift
import TCCCSDK
// 获取tcccSDK 单例
let tcccSDK: TCCCWorkstation = {
   return TCCCWorkstation.sharedInstance()
}()
// 获取SDK版本号
let version = TCCCWorkstation.getSDKVersion()
```

- Objective-C代码示例
``` objectivec
// 引入 OC 头文件
#import "TCCCSDK/tccc/platform/apple/TCCCWorkstation.h"
// 获取tcccSDK 单例
- (TCCCWorkstation*)tcccSDK {
    if (!_tcccSDK) {
        _tcccSDK = [TCCCWorkstation sharedInstance];
    }
    return _tcccSDK;
}
// 获取SDK版本号
NSString* version = [TCCCWorkstation getSDKVersion];
```


具体编码实现可参见 [API 概览以及示例](https://write.woa.com/document/113673679891435520)。

## 常见问题

### 如何查看 TCCC 日志？

TCCC 的日志默认压缩加密，后缀为 .log。
- iOS 日志路径：`sandbox/Documents/tccc`


### 在 iOS 下回调是否都在主线程

Swift、OC 接口的所有回调均在主线程，开发者无需特别处理。但 c++ 接口下回调都不在主线程，需要业务层面上判断并且把他转为主线线程：
``` cpp
if ([NSThread isMainThread]) {
    // 在主线程，直接可以处理
    return;
}
dispatch_async(dispatch_get_main_queue(), ^{
    // 回调在非主线程。
});
```

