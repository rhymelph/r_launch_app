import Flutter
import UIKit

public class SwiftRLaunchAppstorePlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "r_launch_appstore", binaryMessenger: registrar.messenger())
    let instance = SwiftRLaunchAppstorePlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch call.method {
      case "launchIOSStore":
          guard let appId = (call.arguments as? Dictionary<String, Any>)?["appId"] as? String else {
                          result(FlutterError(code: "参数appId不能为空", message: nil, details: nil))
                          return
                      }
          upgradeFromAppStore(appId: appId,result: result)
          break
      default:
          result(FlutterMethodNotImplemented)
      }
  }
    
    //跳转到应用的AppStore页页面
    func upgradeFromAppStore(appId: String,result: @escaping FlutterResult) {
        getInfoFromAppStore(appId: appId) { dict in
            if dict == nil{
                result(false)
            }else{
                let res = dict!["results"] as! NSArray
                let xx = res[0] as! NSDictionary
                let urlString = xx["trackViewUrl"] as! String
                result(self.openUrl(url: urlString))
            }
           
        } error: { error in
            result(false)
        }
    }
    
    //获取应用信息
        func getInfoFromAppStore(appId:String,complete:@escaping(_ result:NSDictionary?)->Void,error:@escaping(_ error:Error?)->Void) {
            let checkLink =  "https://itunes.apple.com/lookup?id="
            let appUrl = checkLink + appId
                let url = NSURL(string: appUrl)! as URL
                let request = NSMutableURLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 30)
                request.httpMethod = "GET"
                
                let session = URLSession.shared
                
                let task = session.dataTask(with: request as URLRequest){(data,response,err) in
                    if err == nil{
                        if data == nil{
                            NSLog("获取appId:%@ 对应的appStore信息失败",appId)
                            complete(nil)
                        }
                        let httpRequest = response as! HTTPURLResponse
                        if httpRequest.statusCode == 200 {
                                let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableLeaves) as! NSDictionary
                            if json["resultCount"] as! Int > 0{
                                complete(json)
                            }else{
                                NSLog("获取appId:%@ 对应的appStore信息失败，未上架或ID不存在", appId)
                                complete(nil)
                            }
                        }else{
                            NSLog("获取appId:%@ 对应的appStore信息失败，未上架或ID不存在", appId)
                            complete(nil)
                        }
                    }else{
                        NSLog("获取appId:%@ 对应的appStore信息失败",appId)
                        error(err)
                    }
                }
            task.resume()
        }
    
    func openUrl(url:String) ->Bool{
            if let url = URL(string: url) {
                //根据iOS系统版本，分别处理
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url, options: [:],completionHandler: {(success) in })
                } else {
                    UIApplication.shared.openURL(url)
                }
                return true;
            }
            return false;
        }
}
