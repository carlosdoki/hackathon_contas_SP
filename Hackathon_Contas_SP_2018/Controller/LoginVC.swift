//
//  LoginVC.swift
//  Hackathon_Contas_SP_2018
//
//  Created by Carlos Doki on 25/04/18.
//  Copyright © 2018 Carlos Doki. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import SwiftKeychainWrapper

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var senhaTxt: UITextField!
    @IBOutlet weak var CAUFESPSwitch: UISwitch!
    @IBOutlet weak var segLogin: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        emailTxt.setBottomLine(borderColor: emailTxt.textColor!)
        senhaTxt.setBottomLine(borderColor: senhaTxt.textColor!)
//        Messaging.messaging().subscribe(toTopic: "/topics/news")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = KeychainWrapper.standard.string(forKey: KEY_UID) {
            userUUID = user
            print("DOKI: ID found in keychain")
            performSegue(withIdentifier: "telaPrincipal", sender: nil)
        } else {
        }
    }
    @IBAction func btnEntrarPressed(_ sender: RoundedButton) {
        if (emailTxt.text?.contains("@")) == nil || emailTxt.text == "" {
            let alert = UIAlertController(title: "Alerta", message: "Email inválido ou incompleto", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if (senhaTxt.text == "") {
            let alert = UIAlertController(title: "Alerta", message: "Senha inválida ou incompleta", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        if CAUFESPSwitch.isOn {
            
        } else {
            if segLogin.selectedSegmentIndex == 0 {
                Auth.auth().signIn(withEmail: emailTxt.text!, password: senhaTxt.text!) { (user, error) in
                    if error == nil {
                        print("You have successfully logged in")
                        let keychainResult = KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
                        print("DOKI: Data saved to keychain \(keychainResult)")
                        self.performSegue(withIdentifier: "telaPrincipal", sender: nil)
                    } else {
                        print("Error")
                    }
                };
            } else {
                Auth.auth().createUser(withEmail: emailTxt.text!, password: senhaTxt.text!) { (user, error) in
                    if error == nil {
                        print("You have successfully signed up")
                        let keychainResult = KeychainWrapper.standard.set((user?.uid)!, forKey: KEY_UID)
                        print("DOKI: Data saved to keychain \(keychainResult)")
                        self.performSegue(withIdentifier: "telaPrincipal", sender: nil)
                    } else {
                        print("Error")
                    }
                }
            }
        }
    }
    
}

