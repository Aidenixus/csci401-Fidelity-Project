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
            //TODO: Add user to current user
            //Load the loaded user
            var ref: DocumentReference? = nil
            ref = db.collection("users").addDocument(data: [
                "name": username,
                "password": password,
                "balance":  0,
                "stock": [],
                "friends": [],
                "cards": []
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
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
