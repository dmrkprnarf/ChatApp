//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Arif Demirkoparan on 3.02.2023.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var paswordTextfiled: UITextField!
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if let email = emailTextfiled.text , let password = paswordTextfiled.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let error = error {
                    let alert = UIAlertController(title: K.warning, message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: K.click, style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.performSegue(withIdentifier: K.loginIDE, sender: self)
                }
            }
        }
    }
}
