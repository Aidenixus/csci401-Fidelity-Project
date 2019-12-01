//
//  SignUpViewController.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/10/30.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.isSecureTextEntry = true
        reenteredPasswordTextField.isSecureTextEntry = true
        usernameTextField.isSecureTextEntry = false
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reenteredPasswordTextField: UITextField!
    @IBAction func didTapJoinButton(_ sender: UIButton) {
        veryfySignUp(username: usernameTextField.text!,   password: passwordTextField.text!,
            reenteredPassword: reenteredPasswordTextField.text!)
    }
    
    func veryfySignUp(username: String, password: String, reenteredPassword: String){
            
        let db = Firestore.firestore()
         //Add a new document with a generated ID
        
        for user in userDatabase{
            if user.username == username {
                let sameUserAlert = UIAlertController(title: "Username already taken", message: nil, preferredStyle: UIAlertController.Style.alert)
                sameUserAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in sameUserAlert.dismiss(animated: true, completion: nil)
                 }))
                self.present(sameUserAlert, animated: true, completion: nil)
                return
            }
        }
        
        let failureAlert = UIAlertController(title: "Password does not match", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        failureAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in failureAlert.dismiss(animated: true, completion: nil)
        }))
            
            
        let SuccessAlert = UIAlertController(title: "Sign up success", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        SuccessAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in SuccessAlert.dismiss(animated: true, completion: nil)
        }))
        
        var verified = false;
        if(password == reenteredPassword) {
            print("Yes")
            verified = true;
        }
        else{
            print("No")
        }
        if(verified){
            //TODO: Add user to current user, since we have to re-login the page, don't need to set currUser
            var newUser = User()
            newUser.username = username
            newUser.password = password
            userDatabase.append(newUser)
//            currUser = newUser
            db.collection("users").document(username).setData([
                "name": username,
                "password": password,
                "balance":  0,
                "investmentBalance": 0,
                "friends": [],
                "cards": [],
                "stock": [String: Int]()
                ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: ", username)
                }
            }
            self.present(SuccessAlert, animated: true, completion: nil)
        }
        else
        {
            self.present(failureAlert, animated: true, completion: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination
     // Pass the selected object to the new view controller.
    }
    */

}
