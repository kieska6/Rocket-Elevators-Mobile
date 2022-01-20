

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoginRequest.shared.email = ""
        LoginRequest.shared.password = ""
        
        serverRequest.delegate = self
        serverRequest.requestWithHeaderandBody(vc: self, url: Apis.login, params: LoginRequest.shared.returnLoginParams(), method: .post, type: "", loading: true, headerType: .headerWithoutAuth)
    }


}

extension ViewController: serverResponse{
    func onSuccess(json: JSON, val: String) {
        print(json)
    }
}
