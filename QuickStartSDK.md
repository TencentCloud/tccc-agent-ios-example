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

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6bde07c09c111eead3b5254007e6a5b.jpeg?q-sign-algorithm=sha1&q-ak=AKIDtkPQJ3CA3pA-kaHvQ3V0YcpCKy3ZZvMa-rco-bE18b02AZHrNpHPYUwg6ad3vYlP&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=266584a71ac51c2a988e3d78261bf15e892c0a74&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa61b9ba7238ba7ff4a7b161a75706a29cK6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokgC_XnOO06ZuwmnIvD7eDpITRFYuYkbkHR-c8N0zE3oX)

3. 单击** Link Binary with Libraries** 项展开，单击底下的“**+**”号图标去添加依赖库。

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6d0af9e09c111ee95bc5254002af9e0.png?q-sign-algorithm=sha1&q-ak=AKIDoVPE0XS6L7B8fglwZRbxxaeHavoNYuIwtC-C0PwLXRB2Zrc9C7DSCeRwSeEm_q6d&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=b8863b14e4f5b92676666c442823d893c00e1f62&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa4759f5a718a12a96ae922012939ed064K6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokoVkI1RjOXYmUTf2Ti9ZfS2XY6Zk6BlMAQdUHgp1s8TM)

4. 依次添加下载的 **TCCCSDK.Framework**、**TXFFmpeg.xcframework**、**TXSoundTouch.xcframework，**及其所需依赖库 **GLKit.framework**、**AssetsLibrary.framework**、**SystemConfiguration.framework**、**libsqlite3.0.tbd**、**CoreTelephony.framework**、**AVFoundation.framework**、**OpenGLES.framework**、**Accelerate.framework**、**MetalKit.framework**、**libresolv.tbd**、**MobileCoreServices.framework**、**libc++.tbd**、**CoreMedia.framework**。

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6baf71d09c111ee8ec2525400c56988.png?q-sign-algorithm=sha1&q-ak=AKID6pb4oPkWwjx-2ehg5RssBWVW6Mh9UHuYVYJ7fsBRDD0vy95Vx_mRE1SxrFFq0ihm&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=8f4839337a9efc49883178c9e5ebc4b2a0f55e8b&x-cos-security-token=yAtvcyFninXHxO17zjbt9GBljR8FUXya8a6a00c87c35cb34953836eb54429a69jPMdC12hWaiGeEpz-3Y48SsHgxzqJ9RKlFTGVzauNZMx_1mOAwwMYp5f5KHOBId5PvCsi_Ila20CSGoNhGipJJAfXIR9z2XI6TJYXGNJEHNf66CNkcLk9wzxj-jss8Lk2TlZN1P-w4oJK2mnjhP1XUhkwG5mOXyou6FuzFEuZ59UsP8KNToAJA451Y7zZDeIr66r6xuWlp0czIt9-fN3Ebi7SmT4yX-1PzYgVZPlAipN7ijxdZXnTKweQrgQ2MmsMqc6JRvYYAY7v7212g2IhJ9DMtZOoHHldNJ5NMM5l_2supytZnS-6SsH0d1Ue-vD)

5. 单击 **General**，选择 **Frameworks**，**Libraries**，**and Embedded Content**，检查 **TCCCSDK.framework** 所需要动态库 **TXFFmpeg.xcframework**、**TXSoundTouch.xcframework **是否已经添加，是否正确选择 Embed & Sign，如果没有单击底下的 “**+**” 号图标依次添加。

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100031390357/f8143fdb0c1811eead3b5254007e6a5b.png?q-sign-algorithm=sha1&q-ak=AKIDGtCNW0VTuvjwVyPsfw5YmREFFpPOKjOHl1GqynZqp5zSoX4bs5iEmXVNsYvXe_49&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=b3e0fbfb3ab4d67145b26d1bcb4650c8dfad2109&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa6e7cc491a89b13a37e21fafd4b979327K6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokstQ3pToa0-5rK7rH60mjPazVC70bEYuwtOZe9e2gkzW)

6. 在工程 target 中 Build Settings 的 **Other Linker Flags **增加 -ObjC 配置。

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100031390357/fd2ebe360c1811ee8ec2525400c56988.png?q-sign-algorithm=sha1&q-ak=AKIDlwltXcYP6cCmATEgLfp9JOi78B7QYMxYIA328dWs9FUZBoR0EgGhS0W3QS2kLPNN&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=ccfe6d0d77196cb470a1a328c93da199340bf2a0&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa5ab0e6343d66949a2cd3f5886465c716K6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokm110T827YMjr6zC5oXKnbD2gLegTGcR-wXcxrqpob17)


## 配置 App 权限
1. 如需使用 SDK 提供的音视频功能，需要给 App 授权麦克风的使用权限。在 App 的 Info.plist 中添加对应麦克风在系统弹出授权对话框时的提示信息。

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6b5cc7e09c111eead3b5254007e6a5b.png?q-sign-algorithm=sha1&q-ak=AKID9AyrgI7q8iVPOjFyf1BsL5kvIJWqXETWv7VijaE2guIo50nDpFf0prLLmjrRmVwZ&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=46e9b5ccd8263a80c3648e058b1eb4ca46f94606&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa60ffdaeb70fbda66f6a9bb2c99de8a05K6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokrehh1wlPmcNCrjV5zcxjSTmo9u4KOelyyee87TL0olh)

2. 如需 App 进入后台仍然运行相关功能，可在 XCode 中选中当前工程项目，并在 Capabilities 下将设置项  Background Modes 设定为 ON，并勾选 Audio，AirPlay and Picture in Picture ，如下图所示：

   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6cfe44f09c111eea359525400088f3a.png?q-sign-algorithm=sha1&q-ak=AKIDTl_GYkHbGTj2jtcDY91I8wv7wwok17iWJgzAed924YfwMJLXUAztVFAPjy1mUP7J&q-sign-time=1711072685;1711076285&q-key-time=1711072685;1711076285&q-header-list=&q-url-param-list=&q-signature=38b2f79e1ca4e923ca3c638d7521d8afcc0206fd&x-cos-security-token=RMQGOrgvlCOAFDmmeIwSCdgdZ1I5vmNa769e3538c6ca708bee2eee8a55bab299K6H_mFYTw_uqurePTz3tM3chS1F7Sd_wrP4OkTI_asC3uT7xggFIIZRNJ71nGGbtOWQMxD5Xg_u_di_ER4n3jAsuZmFb-sMMkHRPEVtxxWeQiBMGV_4dFK5bR10Ggpc-wERYeN5PL1E_JmLvWx3JLzvTu87PcA2zQmahev2AQqPvpsAn5g6R3TaminIiR6QfTELyOgJDCmyUucbKNx0PzajCHHo5DUCZgwYyIIe5fSnplK2fwUiWedglPinAcujkcFrXjP7_CLOjT14bLXrokuaoyVD83JsGuY0jlT2hie0kF8qiV0kw05d6hVrrzRGV)


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

