

import Foundation
import Alamofire

protocol serverResponse {
    func onSuccess(json:JSON,val:String)
}

//@available(iOS 13.0, *)
class Services: UIViewController {
    
    var delegate:serverResponse!
    
    let headersWithoutAuth: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    
    let headersWithAuth: HTTPHeaders = [
        "Authorization": "Bearer " + (userGlobalToken ?? "")
    ]
    
    // MARK: Request with body and header
    func requestWithHeaderandBody(vc:UIViewController , url:String , params:[String:Any] , method:HTTPMethod , type:String , loading:Bool, headerType: HeaderType){
        
        let loaderVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        let apiHeader = headerType == .headerWithAuth ? headersWithAuth : headersWithoutAuth
        
        if CheckInternet.Connection(){
            if loading{
                loaderVC.modalPresentationStyle = .overCurrentContext
                vc.present(loaderVC, animated: false, completion: nil)
            }
            
            AF.request(Apis.baseURL + url , method: method, parameters: params , encoding: JSONEncoding.default, headers: apiHeader).responseJSON { (response) in
                
                switch response.result{
                    
                case .success(let value):
                    let json = JSON(value)
                    
                    let status: String = json["status"].string!
                    let success: Bool = json["success"].bool!
                    let message: String = json["message"].string!
                    
                    // if API hits with no error i.e status 200
                    if json["status"] == 200{
                        
                        loaderVC.dismiss(animated: false, completion: nil)
                        if let del = self.delegate{
                            del.onSuccess(json: json["data"], val: type)
                        }
                        
                    }
                    // If any error occurs
                    else if json["status"] == 401{
                        
                        loaderVC.dismiss(animated: false, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            // hidding allert messages
                            self.showPopupAlert(title: Messages.error, message: message)
                        }
                    }else if json["status"] == 500{
                        
                        loaderVC.dismiss(animated: false, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            // hidding alert messages
                            self.showPopupAlert(title: Messages.error, message: message)
                        }
                    }
                    
                case .failure(let err):
                    print(err.localizedDescription)
                    //                    loaderVC.dismiss(animated: false, completion: nil)
                    loaderVC.dismiss(animated: false, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showPopupAlert(title: Messages.error, message: Messages.serviceFailure)
                    }
                    break
                    
                }
            }
        }else{
            
            self.showPopupAlert(title: Messages.error, message: Messages.noInternet)
        }
    }
    
    // MARK: Request GET API
    func requestGETAPI(vc: UIViewController , url : String, method: HTTPMethod, type: String, loading: Bool) {
        
        let loaderVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoaderViewController") as! LoaderViewController
        
        if CheckInternet.Connection(){
            if loading{
                
                loaderVC.modalPresentationStyle = .overCurrentContext
                vc.present(loaderVC, animated: false, completion: nil)
            }
            
            AF.request(Apis.baseURL + url).responseJSON { (response) in

                switch response.result{
                    
                case .success(let value):
                    
                    let json = JSON(value)
                    
                    let status: String = json["status"].string!
                    let success: Bool = json["success"].bool!
                    let message: String = json["message"].string!
                    
                    if json["status"] == 200{
                        
                        loaderVC.dismiss(animated: false, completion: nil)
                        if let del = self.delegate{
                            del.onSuccess(json: json["data"], val: type)
                        }
                    }else{
                        loaderVC.dismiss(animated: false, completion: nil)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.showPopupAlert(title: Messages.error, message: message)
                        }
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    loaderVC.dismiss(animated: false, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.showPopupAlert(title: Messages.error, message: Messages.serviceFailure)
                    }
                    break
                }
            }
        }else{
            loaderVC.dismiss(animated: false, completion: nil)
            self.showPopupAlert(title: Messages.error, message: Messages.noInternet)
        }
    }
}
