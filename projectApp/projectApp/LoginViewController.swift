//
//  LoginScreen.swift
//  projectApp
//
//  Created by Minxuan Song on 10/10/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class User {
    var username: String
    var password: String
    
    init(username: String, password: String){
        self.username = username;
        self.password = password;
    }
}

let dummyUser: User = User(username: "xubozhu@usc.edu", password: "123")

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBAction func didTapLogin(_ sender: UIButton) {
        print("username: ", usernameTextField.text!)
        print("password: ", passwordTextField.text!)
        verifyLogin(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    @IBAction func didTapSignUp(_ sender: UIButton) {
    }
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    func verifyLogin(username: String, password: String)
    {
        
        let alert = UIAlertController(title: "Wrong Password, please try again.", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        //  do query of username to password to backend now
        
        // do verification based on the username/password fetched from backend
        var verified = false;
        if (username == dummyUser.username && password == dummyUser.password){
            verified = true;
        }
        
        if (verified)
        {
            // jump into the profile picture (or tab bar view controller page, with Profile Picture displayed on default
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            
            guard let destination = mainStoryboard.instantiateViewController(withIdentifier: "tabBarViewController") as? TabBarViewController else {
                print("Couldn't find the view controller")
                return
            }
            
            destination.modalTransitionStyle = .crossDissolve
            destination.modalPresentationStyle = .fullScreen
            
            present(destination, animated: true, completion: nil)
            
        }
        else
        {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
