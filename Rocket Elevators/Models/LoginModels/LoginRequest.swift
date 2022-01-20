

import Foundation

class LoginRequest{
    
    var email: String = ""
    var password: String = ""
    
    static let shared = LoginRequest()
    
    func returnLoginParams() -> [String:Any]{
        
        let params:[String:Any] = [
            "email": email,
            "password": password
        ]
        return params
        
    }
}
