//
//  BaseViewController.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import UIKit
import AnimatedTextInput

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
 
    // MARK:- View Lifecycle
    override func viewDidLoad(){
        super.viewDidLoad()
//
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .light
//        } else {
//
//        }
        
        self.navigationController?.interactivePopGestureRecognizer!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func pushToBack() {
        self.navigationController?.popViewController(animated: true)
    }
   
    // MARK:- Tap Gesture Recognizer
    public func setGestureRecognizer() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer (target: self, action: #selector(BaseViewController.handleTapGesture(_:)))
        tapRecognizer.numberOfTapsRequired = 1
        return tapRecognizer
    }
    
    @objc func handleTapGesture(_ tapGesture : UITapGestureRecognizer) {
        
    }
    
}

extension BaseViewController {
    
    func pushToSecondVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: VCIdentifier.secondVC.rawValue) as! SecondViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}

//MARK:- Animated Text Input Styles
@available(iOS 13.0, *)
struct CustomTextInputStyle: AnimatedTextInputStyle {
    let placeholderInactiveColor = Colors.primaryColor
    let activeColor = UIColor.label
    let inactiveColor = Colors.primaryColor
    let lineInactiveColor = Colors.primaryColor
    let lineActiveColor = UIColor.label
    let lineHeight: CGFloat = 1
    let errorColor = Colors.errorColor
    let textInputFont = UIFont.systemFont(ofSize: 16, weight: .semibold)
    let textInputFontColor = UIColor.label
    let placeholderMinFontSize: CGFloat = 12
    let counterLabelFont: UIFont? = UIFont.systemFont(ofSize: 12)
    let leftMargin: CGFloat = 0
    let topMargin: CGFloat = 20
    let rightMargin: CGFloat = 0
    let bottomMargin: CGFloat = 2
    let yHintPositionOffset: CGFloat = 0
    let yPlaceholderPositionOffset: CGFloat = 0
    public let textAttributes: [String: Any]? = nil
}

