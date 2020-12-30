//
//  CommonButton.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import Foundation
import UIKit

@IBDesignable
final class CommonButton: UIButton {
    
    @IBInspectable var defaultBackgroundColor: UIColor?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        
        self.layer.borderWidth = 2
        self.layer.borderColor = Colors.primaryColor.cgColor
        
        if defaultBackgroundColor == nil {
            self.backgroundColor = UIColor.clear
        } else {
            self.backgroundColor = UIColor(hex: "0xc4c4c4").withAlphaComponent(0.2)
        }
    }
}
