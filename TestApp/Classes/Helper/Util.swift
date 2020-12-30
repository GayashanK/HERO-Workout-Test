//
//  Util.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import UIKit

class Util: NSObject {
    
    static var instance = Util()
    
    func showAlert(title: String? = nil,message: String? = nil, viewController: UIViewController, handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        //to change font of title and message.
        let titleFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold)]
        let messageFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .regular)]
        
        let titleAttrString = NSMutableAttributedString(string: title ?? "", attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message ?? "", attributes: messageFont)
        
        alertController.setValue(titleAttrString, forKey: "attributedTitle")
        alertController.setValue(messageAttrString, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "Dismiss", style: .default, handler: handler)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: handler)
        alertController.addAction(okAction)
//        alertController.addAction(cancelAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let pwRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z].).{12,}$"

        let pwPred = NSPredicate(format:"SELF MATCHES %@", pwRegEx)
        return pwPred.evaluate(with: password)
    }

}

