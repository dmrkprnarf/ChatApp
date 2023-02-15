//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Arif Demirkoparan on 3.02.2023.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var paswordTextfiled: UITextField!
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        if let email = emailTextfiled.text , let password = paswordTextfiled.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let  e = error {
                    let alert = UIAlertController(title: K.warning, message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: K.click, style: UIAlertAction.Style.cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else {
                    self.performSegue(withIdentifier: K.registerIDE, sender: self)
                }
            }
        }
    }
}
