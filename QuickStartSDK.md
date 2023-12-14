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


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6bde07c09c111eead3b5254007e6a5b.jpeg?q-sign-algorithm=sha1&q-ak=AKIDpEQ08UNh-gc3tQwyPtCOvkFV_v2zXQsi-cESn0vIeps1ajqvPSuUV-SeEMRxdHbe&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=c53f6c5303f9b29ecbfb6fe888dbf1014ae714b9&x-cos-security-token=ebWbIHD3xAV2lR4j9hAgntccD3ABCmxa51b733eba20ba9898c770f358b260100L_3fUlQ5aDFe1Yf62g5jo7TCXGDJ_CuzKBET0V_NuYWPKUW1OaBqBz0zPlCFzeQxLPuPi4r3tsQlC7m1qs_fnFpsJq5iLH8A6k9gQ7GvhWS9AGjL9oqdlFd-FgVkgee6uOMnRbOMgz1pMTx32liYH-aPR_kgoWEdBLb89oUZSwviRDH7JJiN07dq0ZDXdCdJuBPQ7DcJI6nZLzS3GVWBejRaQ-UmsURKGAHsNTSpTnbVZ_X_58sAv_nSxomRjrS_axMnwdBAroXQx3V1_SfSysBjONL_YQqKLzZ5DcGMU0RIdIodM2KnXIZy6tmr-UDhR8h6IxzWYA5yqztq7JPMIWtallabgLvRjQ8eciWR3PvDVInjIWRs9-Xm2FM4YVRc)

3. 单击** Link Binary with Libraries** 项展开，单击底下的“**+**”号图标去添加依赖库。


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6d0af9e09c111ee95bc5254002af9e0.png?q-sign-algorithm=sha1&q-ak=AKID9rIswWUiYjh8xEKvmnIbkRn1V8e6oIFKmdMs77xrwonk8KTV3RgQ7rZuNENsbQk4&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=6a4fe2a44e2816b140f10acf89fe75bf2ba0239b&x-cos-security-token=ebWbIHD3xAV2lR4j9hAgntccD3ABCmxa32aa1d0c966a965449363d0c3fa6d8c6L_3fUlQ5aDFe1Yf62g5jo7TCXGDJ_CuzKBET0V_NuYW8ywS0WcFm4CcPIZguD99N2ajROZW4TF9j73sOERr1KOtsRNDj5fZBYdwLIcCdXrKpJqdkcB5aOco-e7CYMmZfjQ0m8VTTlWIrkZGw01mHPxfSM8EXA3v0w11qtIYNL7bEieQk1TxZR9C-HnPpMsY7-zEMLoSNAIuczlktPNJ2HZhRudlbpw2biJvF9-KsnC2KgnCXKe1gcsRGg8YaLCopPYZIlbhdUUIq_kKzVu1ixlDplAgeRikEKy6G6kf9cYffDZNM9DWMAdO0C7U8omOC6hePwtDcTcU16pwX9HhHju2iJMnv8uVhgMSpDElBawTX7gZueXtmZXei0qGEnfUr)

4. 依次添加下载的 **TCCCSDK.Framework**、**TXFFmpeg.xcframework**、**TXSoundTouch.xcframework，**及其所需依赖库 **GLKit.framework**、**AssetsLibrary.framework**、**SystemConfiguration.framework**、**libsqlite3.0.tbd**、**CoreTelephony.framework**、**AVFoundation.framework**、**OpenGLES.framework**、**Accelerate.framework**、**MetalKit.framework**、**libresolv.tbd**、**MobileCoreServices.framework**、**libc++.tbd**、**CoreMedia.framework**。


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6baf71d09c111ee8ec2525400c56988.png?q-sign-algorithm=sha1&q-ak=AKID8e-uTLhtxDVepiFjarw6KmbssksGxiHsRygk6nlIMsg0aHpSzIvatizjPOu8-ORw&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=2ca55947a3e62321ceec5cdb9e118d1f16ffdde7&x-cos-security-token=ebWbIHD3xAV2lR4j9hAgntccD3ABCmxa33b0bffb4600327a9465eb46f481e560L_3fUlQ5aDFe1Yf62g5jo7TCXGDJ_CuzKBET0V_NuYW8ywS0WcFm4CcPIZguD99N2ajROZW4TF9j73sOERr1KOtsRNDj5fZBYdwLIcCdXrKpJqdkcB5aOco-e7CYMmZfjQ0m8VTTlWIrkZGw01mHPxfSM8EXA3v0w11qtIYNL7bEieQk1TxZR9C-HnPpMsY7r6ciXtyBj8k_ze0GOmBawp6yPz-_LrUh1Yrw8uMdQWWPy6o499O-yyNvSm6afVIS60YyKf2M9wlC-tP88vo3v1HniN7RWQi_kdMf2EtzPobf7bZoywCvJiipRDN0T2N5z6eEN-sA6HKTbDXbK00EStJovUPk_oRCgUn7-KJ95_SntIjV9W77vBoHksNgp4CO)

5. 单击 **General**，选择 **Frameworks**，**Libraries**，**and Embedded Content**，检查 **TCCCSDK.framework** 所需要动态库 **TXFFmpeg.xcframework**、**TXSoundTouch.xcframework **是否已经添加，是否正确选择 Embed & Sign，如果没有单击底下的“**+**”号图标依次添加。


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100031390357/f8143fdb0c1811eead3b5254007e6a5b.png?q-sign-algorithm=sha1&q-ak=AKIDl4TQIhp-iKs_H0qzWgAZ3XbNhaBeNVcQG7wAK_yoP9EKulvkDqtfEZ2jYzxMfWEy&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=650f25ca73ab3ff68ecc8bf74e8e5bb62a1fddbd&x-cos-security-token=GjpwYJFHYeOeH2cPS49yWQEPa5iEPgZa4ddf617f26d1205480a0af2015101852QIKunnnaBxE2n9QSd3XYizxOskpLBUAfu2rE9xzpiBfDyXVRCnzBvQ42Tz0q02H0V8rnzoCW0WWP7U0HCPD0cQjszpjFYO0tjILD3hW0nId88C3lHLiOEHS6la91B6Jpm5yLpxsJBcvJzfE-9vCtLfuWRNzZM0EPZbpsNHehYj8i3398Up1zjmW3t9pR4W-xQuNn5K_jeG1IW5rk1H5pKan7gomEjYGLYZ2JzCD1NrqgRc08qnCm4l3KVuc5rZUbpjyZMtGRxJocVwdgnRD5CEU0fEObKz9x1qbnIXZ1-C6xc0ltBcVqA6WDauFo1q5h6uE1bjFEiXPdLfqAL5t3wsNj32Tw2nF_ENq2w2Jfhe7NeSmqBGTmSIEXY4Aikyfw)

6. 在工程 target 中 Build Settings 的 **Other Linker Flags **增加 -ObjC 配置。


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100031390357/fd2ebe360c1811ee8ec2525400c56988.png?q-sign-algorithm=sha1&q-ak=AKIDeOO4tht6Y4NHWdEUHIl50u423t5QioQGF4VY1UCAmYoYCS3m_oIbPKWvctwpvqLR&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=7e43cec2193d0261f0f905f8803c5efb665806e8&x-cos-security-token=ebWbIHD3xAV2lR4j9hAgntccD3ABCmxa856f709ad5f7662dbef0b3595b9ecd7eL_3fUlQ5aDFe1Yf62g5jo7TCXGDJ_CuzKBET0V_NuYW8ywS0WcFm4CcPIZguD99N2ajROZW4TF9j73sOERr1KOtsRNDj5fZBYdwLIcCdXrKpJqdkcB5aOco-e7CYMmZfjQ0m8VTTlWIrkZGw01mHPxfSM8EXA3v0w11qtIYNL7YKSUkkOW2uokPYzu_rYF8dFZOXo8hCKnw1Jc9oXNumByZEh9aL8nt2cTtbR0ve2wWwfzhkAU86glRXo02DD2_vXtCoYQLjjHpfZlRWK2ZL8iu8pyKo1xPZ0D2gA9OfcbCfnIgZbzLo3PtcBr3KlYi8shegOy00OkAz6jUlnSlRgQLhlGcRXxKyLNF7BKiMWPRsZ3pH5LeCcXwxMlHkrejF)


## 配置 App 权限
1. 如需使用 SDK 提供的音视频功能，需要给 App 授权麦克风的使用权限。在 App 的 Info.plist 中添加对应麦克风在系统弹出授权对话框时的提示信息。


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6b5cc7e09c111eead3b5254007e6a5b.png?q-sign-algorithm=sha1&q-ak=AKIDXuKtqpB8Kpmrnq609Ufa7rPjkEwLo_C08EhqC8yT6GCyCtbPZIXKcLAWj0ON6CiQ&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=0c69b82471c2bdfcef0a2a0ceaf85411755d7a5c&x-cos-security-token=CCC0wTPzBbTX6NPm44dgfaMe75NXotHac1756a7df72c81f8c319a14f096b8ce4YoiAIMrdXxNbVVKTL6g5MJjmhZfr4FzZqMVl7R7mfteM2gUufn0wCmRAXJPUu8O8VdLmyZRn7kq-_mLp16vzGKXGmTgw1yuXn0GbkSMPaQL1_CSdwy_bs-G6GDitE0qUouBEe8PTGyQPis6xzzpqy2Xo0Serz-uwezw3cgKcTzDUPTqDW85VrSAUniZk5l7RNh40etkviG6bVeYdt1wwoRwoGa-nMM5eV1j2hvJrhkZDBIJRfpWIvVggatMTTHLDyi0yjLZAfn8Mgsoz83ldf-woybTXXsKYoGwUrDWSnXcOhY2IYyiqfmbwawEsxwQpxHhTA2EK_hIZWoCWh3NNsZitWpova4AzSzgsQxE7djqKYN-vmWuQEbmMDRl_oTkU)

2. 如需 App 进入后台仍然运行相关功能，可在 XCode 中选中当前工程项目，并在 Capabilities 下将设置项  Background Modes 设定为 ON，并勾选 Audio，AirPlay and Picture in Picture ，如下图所示：


   ![](https://write-document-release-1258344699.cos.ap-guangzhou.tencentcos.cn/100027565564/b6cfe44f09c111eea359525400088f3a.png?q-sign-algorithm=sha1&q-ak=AKID2Om8fI6PvfK15wDtQXYHZa2twpgogCzUmDMeVrclGY7VcQojom844zmzLgMw1x5m&q-sign-time=1702519761;1702523361&q-key-time=1702519761;1702523361&q-header-list=&q-url-param-list=&q-signature=836665b60c829c71873508a83ded9e1c4d5df643&x-cos-security-token=ebWbIHD3xAV2lR4j9hAgntccD3ABCmxae7e0e9777286c9dbbc8b6eec5767d5f9L_3fUlQ5aDFe1Yf62g5jo7TCXGDJ_CuzKBET0V_NuYW8ywS0WcFm4CcPIZguD99N2ajROZW4TF9j73sOERr1KOtsRNDj5fZBYdwLIcCdXrKpJqdkcB5aOco-e7CYMmZfjQ0m8VTTlWIrkZGw01mHPxfSM8EXA3v0w11qtIYNL7bEieQk1TxZR9C-HnPpMsY7RAr47MTOqfXdvg8UMgYHDFCa5jEx-7dIL7htEmyLMEzLZH4c575fiAQ913kchgZtoPY1sPVFDzM6P1xjOQnFJgmuObB1PrjRVgNBNfrsT69MoCwAPqpZtvVCJDO4O30-VAtvmM69oRmUCN0QfNAwSoFcjp2_DmsPLd7X-NIzqP7g-mNqepMOi50fF9wrTE_a)


## 代码实现

目前我们只提供了通过 C++ 接口，可以用下面代码引入头文件：
``` cpp
// 引入C++头文件
#include "TCCCSDK/tccc/include/ITCCCWorkstation.h"

// 使用tccc命名空间
using namespace tccc;
// 获取tcccSDK 单例
ITCCCWorkstation* tcccSDK = getTCCCShareInstance();
// 获取SDK版本号
const char *  version = tcccSDK->getSDKVersion();
```

具体编码实现可参考 [API 概览以及示例](https://write.woa.com/document/113673679891435520)。

## 常见问题

### 如何查看 TCCC 日志？

TCCC 的日志默认压缩加密，后缀为 .log。
- iOS 日志路径：`sandbox/Documents/tccc`


### 在iOS下回调是否都在主线程

目前在 iOS 下回调都不在主线程，需要业务层面上判断并且把他转为主线线程：
``` cpp
if ([NSThread isMainThread]) {
    // 在主线程，直接可以处理
    return;
}
dispatch_async(dispatch_get_main_queue(), ^{
    // 回调在非主线程。
});
```

