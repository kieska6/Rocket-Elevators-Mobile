
import UIKit

class PopupViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var txtTitle: UILabel!
    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var btnOk: UIButton!
    
    //MARK: VARIABLES
    var alertTitle: String = ""
    var alertMessage: String = ""
    var onOK: (() -> Void)?
    
    //MARK: VIEW METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        popupView.backgroundColor = UIColor.white
        txtTitle.text = alertTitle
        txtMessage.text = alertMessage
        
//        popupView.layer.cornerRadius = 15
//        popupView.layer.borderWidth = 1
//        popupView.layer.borderColor = UIColor.odieYellow.cgColor
        showAnimate()
    }
    
    //MARK: ACTIONS
    @IBAction func btnOkClicked(_ sender: Any) {
        onOK?()
        removeAnimate()
    }
}
