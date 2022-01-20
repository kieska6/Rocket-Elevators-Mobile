

import Foundation

struct Apis{
    static let baseURL = "https://rocket-ele.herokuapp.com/api/"
    
    static let login = "auth/login"
}

struct Messages {
    
    static let noInternet = "No Internet Connection"
    static let requestTimeOut = "Request Timed Out"
    static let error = "Error"
    static let serviceFailure = "Service Failure"
}


// Reference to call apis
var serverRequest = Services()

var userGlobalToken = UserDefaults.standard.string(forKey: "USER_SESSION_TOKEN")
