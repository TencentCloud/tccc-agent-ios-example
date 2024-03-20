//
//  TcccExampleSwift.swift
//  tccc-agent-ios-example
//
//  Created by gavinwjwang on 2024/3/20.
//

import TCCCSDK


class TcccExampleSwift : NSObject {
    
    let tcccSDK: TCCCWorkstation = {
        // 创建实例
       return TCCCWorkstation.sharedInstance()
    }()
    
    func initTcccSDK() {
        // 设置TCCC事件回调
        tcccSDK.addTcccListener(self)
        
        // 获取SDK版本号
        let version = TCCCWorkstation.getSDKVersion()
        print(version)
    }
    
    func exampleCode() {
        let param = TXLoginParams()
        // 登录的坐席ID，通常为邮箱地址
        param.userId = "";
        // 登录票据，在登录模式为Agent必填。更多详情请参见[创建 SDK 登录
        // Token](https://cloud.tencent.com/document/product/679/49227)
        param.token = "";
        // 腾讯云联络中心应用ID，通常为1400开头
        param.sdkAppId = 0;
        // 设置为坐席模式
        param.type =  .Agent;
        // 登录
        tcccSDK.login(param) { info in
            // 登录成功
        } fail: { code, message in
            // 登录失败
        }

        
        // 检查登录状态
        tcccSDK.checkLogin {
            // 已登录
        } fail: { code, message in
            // 未登录或者被T了
        }

        // 退出
        tcccSDK.logout {
            // 退出成功
        } fail: { code, message in
            // 退出异常
        }
        
        let callParams = TXStartCallParams()
        // 呼叫的手机号
        callParams.to = "";
        // 号码备注，在通话条中会替代号码显示（可选）
        callParams.remark = "";
        // 发起外呼
        tcccSDK.call(callParams) {
            // 发起呼叫成功
        } fail: { code, message in
            // 发起呼叫失败
        }
        // 结束通话
        tcccSDK.terminate()

        // 切换为扬声器
        tcccSDK.getDeviceManager().setAudioRoute(.TCCCAudioRouteSpeakerphone)
        // 静音
        tcccSDK.mute()
        // 取消静音
        tcccSDK.unmute()

        // 获取SDK版本号
        let version = TCCCWorkstation.getSDKVersion()
        print(version)
    }
    
    func destroyTcccSDK() {
        // 移除TCCC事件回调
        tcccSDK.removeTCCCListener(self)
        // 销毁实例
        TCCCWorkstation.destroySharedIntance()
    }
}

extension TcccExampleSwift : TCCCDelegate {
    func onError(_ errCode: TCCCErrorCode, errMsg: String, extInfo: [AnyHashable : Any]?) {
        // 错误事件回调
    }
    func onWarning(_ warningCode: TCCCCWarningCode, warningMsg: String, extInfo: [AnyHashable : Any]?) {
        // 警告事件回调
    }
    
    func onNewSession(_ info: TXSessionInfo) {
        // 新会话事件。包括呼入和呼出
    }
    func onAccepted(_ sessionId: String) {
        // 对端已接听事件
    }
    func onEnded(_ reason: TXEndedReason, reasonMessage: String, sessionId: String) {
        // 通话结束事件
    }
    
    func onConnectionLost(_ serverType: TXServerType) {
        // SDK 与云端的连接已经断开
    }
    func onConnectionRecovery(_ serverType: TXServerType) {
        // SDK 与云端的连接已经恢复
    }
    func onTry(toReconnect serverType: TXServerType) {
        // SDK 正在尝试重新连接到云端
    }
}


