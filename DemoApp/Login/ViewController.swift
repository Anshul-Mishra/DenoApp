//
//  ViewController.swift
//  DemoApp
//
//  Created by Anshul on 8/3/19.
//  Copyright © 2019 Anshul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPaswword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @IBAction func submitBtnAction(sender: UIButton) {
        
        self.view.endEditing(true)
        
        if self.checkData() {
            
            let params : [String:Any] = ["email": txtUsername.text!, "password" : txtPaswword.text!]
            
            APIManager.sharedInstance.hitLoginAPI(params: params as NSDictionary, url: "https://reqres.in/api/login") { (success, response) in
                
                DispatchQueue.main.async {
                    
                    if success {
                        
                        let data = response as! NSDictionary
                        
                        print(data)
                        
                        if let token = data.object(forKey: "token"), (token is String) {
                            
                            UserDefaults.standard.setValue("Yes", forKey: "loggedIn")
                            
                            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "Home") as! HomeViewController
                            viewController.token = token as? String
                                self.navigationController?.pushViewController(viewController, animated: true)
                            
                        }
                        
                    } else {
                        // Show error alert with message
                        
                        print("error : \((response as! Error).localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func checkData() -> Bool {
        
        if txtUsername.text == "" {
            
            // Show alert for username is empty
            
            return false
        }
        
        if txtPaswword.text == "" {
            
            // Show alert for password is empty
            
            return false
        }
        
        return true
    }

    @objc func keyboardWillShow(notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification:Notification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            txtPaswword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}

