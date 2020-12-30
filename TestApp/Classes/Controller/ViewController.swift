//
//  ViewController.swift
//  TestApp
//
//  Created by Kasun Gayashan on 12/29/20.
//

import UIKit
import AnimatedTextInput

class ViewController: BaseViewController {

    
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var emailTextView: AnimatedTextInput!
    @IBOutlet weak var emailErrImg: UIImageView!
    @IBOutlet weak var emailErrView: UIView!
    @IBOutlet weak var emailErrLbl: UILabel!
    @IBOutlet weak var passwordTextView: AnimatedTextInput!
    @IBOutlet weak var passwordErrImg: UIImageView!
    @IBOutlet weak var passwordErrView: UIView!
    @IBOutlet weak var passwordErrLbl: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var darkBtn: UIButton!
    @IBOutlet weak var lightBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUpView()

        self.loginBtn.addTarget(self, action: #selector(tapNext(_:)), for: .touchUpInside)
    }
    
    //MARK:- Setup the views
    func setUpView() {
        
        if self.traitCollection.userInterfaceStyle == .dark {
            self.maskView.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        } else {
            self.maskView.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        }
        
        //Email text input design
        self.emailTextView.placeHolderText = "E-Mail"
        self.emailTextView.type = .email
        self.emailTextView.style = CustomTextInputStyle()
        self.emailTextView.delegate = self
        self.emailTextView.backgroundColor = UIColor.clear
        
        //Password text input design
        self.passwordTextView.placeHolderText = "Password"
        self.passwordTextView.type = .password(toggleable: true)
        self.passwordTextView.style = CustomTextInputStyle()
        self.passwordTextView.delegate = self
        self.passwordTextView.backgroundColor = UIColor.clear
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            // Trait collection has already changed
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        // Trait collection will change. Use this one so you know what the state is changing to.
    }
    
    //MARK:- Validate Email and Password
    func validateFields(error: @escaping((_ error: String, _ type: String)-> Void)) {
        
        if self.emailTextView.text == "" {
            error("Geben sie ihre E-Mail Adresse ein","email")
            return
        }
        
        if !Util().isValidEmail(self.emailTextView.text ?? "") {
            error("Geben Sie eine gültige E-Mail-Adresse ein", "email")
            return
        }
        
        if self.passwordTextView.text == "" {
            error("Geben Sie Ihr Passwort ein","password")
            return
        }
        
        if !Util().isValidPassword(self.passwordTextView.text ?? "") {
            error("Das Passwort sollte einen Großbuchstaben und ein Sonderzeichen sowie mindestens 12 Zeichen enthalten", "password")
            return
        }
        
        error("","")
        
    }
    
    //MARK:- Button Actions
    @IBAction func tapNext(_: UIButton) {
        
        self.emailErrImg.isHidden = true
        self.emailErrView.isHidden = true
        self.passwordErrImg.isHidden = true
        self.passwordErrView.isHidden = true
        
        validateFields(error: { error,type in
            if error != "" && type == "email" {
                self.emailErrImg.isHidden = false
                self.emailErrView.isHidden = false
                self.emailErrLbl.text = error
            } else if error != "" && type == "password"{
                self.passwordErrImg.isHidden = false
                self.passwordErrView.isHidden = false
                self.passwordErrLbl.text = error
            } else {
                super.pushToSecondVC()
            }
        })
    }
}

//MARK:- Delegates and DataSources
extension ViewController: AnimatedTextInputDelegate {
    
    func animatedTextInputDidBeginEditing(animatedTextInput: AnimatedTextInput) {
        
    }
    
    func animatedTextInputShouldReturn(animatedTextInput: AnimatedTextInput) -> Bool {
        view.endEditing(true)
        return true
    }
    
    func animatedTextInputDidEndEditing(animatedTextInput: AnimatedTextInput) {
        view.endEditing(true)
    }
}

