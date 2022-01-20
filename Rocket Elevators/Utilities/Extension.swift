

import Foundation
import UIKit

extension UIViewController{
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    func showPopupAlert(title : String, message : String, onOK: (() -> Void)? = nil){
        let popupVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        popupVC.alertTitle = title
        popupVC.alertMessage = message
        popupVC.onOK = onOK
        self.addChild(popupVC)
        popupVC.view.bounds = self.view.bounds
        self.view.addSubview(popupVC.view)
        popupVC.didMove(toParent: self)
    }
}
