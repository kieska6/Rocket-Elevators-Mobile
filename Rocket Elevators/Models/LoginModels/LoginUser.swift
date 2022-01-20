

import Foundation

class LoginUser{
    
    var name: String = ""
    
    init(json: JSON){
        self.name = json["name"].stringValue
    }
}
