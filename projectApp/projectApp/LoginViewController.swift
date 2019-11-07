//
//  LoginScreen.swift
//  projectApp
//
//  Created by Minxuan Song on 10/10/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit
import Firebase

let db = Firestore.firestore()
class User {
    var username: String
    var password: String
    var balance:  NSNumber
    var stock: [String]
    var friends: [User]
    var cards: [String]
    
    init(username: String, password: String, balance: NSNumber, stock: [String], friends: [User], cards: [String]){
        self.username = username;
        self.password = password;
        self.balance = balance;
        self.stock = stock;
        self.friends = friends;
        self.cards = cards;
    }
}

var dummyUser: User = User(username: "TommyTrojan", password: "123", balance: 287.98, stock: [
        "Amazon.com, Inc.",
        "Walt Disney Co.",
        "Dell",
        "Microsoft",
        "Apple Inc."
    ],
    friends: [], cards: [
        "**** **** **** 4367",
        "**** **** **** 8734",
        "**** **** **** 3097",
        "**** **** **** 2029"
    ])


class LoginViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Mysterious Code
        LoadFromDatabase (completion: { dataUsername, dataPassword in
            self.usernameDatabase = dataUsername
            self.passwordDatabase = dataPassword
        })
        //Mysterious Code
    }
    //Login Button
    @IBOutlet weak var loginButton: UIButton!
    //Signup Button
    @IBOutlet weak var signUpButton: UIButton!
    
    
    func LoadFromDatabase(completion: @escaping(String, String)->Void )
    {
        
        var dataUsername = ""
        var dataPassword = ""
        db.collection("users").whereField("name", isEqualTo: "TommyTrojan")
            .getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //print("\(dcument.documentID) => \(document.data())")
                    dataUsername = document.get("name") as! String
                    dataPassword = document.get("password") as! String
                    completion(dataUsername, dataPassword)
                }
            }
        }
        // do verification based on the username/password fetched from backend
    }
    
    @IBAction func didTapLogin(_ sender: UIButton) {
        usernameInput = usernameTextField.text!
        passwordInput = passwordTextField.text!
//        print("Outer: ", self.usernameDatabase)
//        print("Outer: ", self.passwordDatabase)
        var verified = false
        if(self.usernameInput == self.usernameDatabase && self.passwordInput == self.passwordDatabase){
            verified = true;
        }

        let alert = UIAlertController(title: "Wrong Password, please try again.", message: nil, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))

        if (!verified) {
            print("Password does not verified")
            self.present(alert, animated: true, completion: nil)
        }
        else {
            // jump into the profile picture (or tab bar view controller page, with Profile Picture displayed on default
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)

            guard let destination = mainStoryboard.instantiateViewController(withIdentifier: "tabBarViewController") as? TabBarViewController else {
                print("Couldn't find the view controller")
                return
            }
            print("Password verified")
            destination.modalTransitionStyle = .crossDissolve
            destination.modalPresentationStyle = .fullScreen
            self.present(destination, animated: true, completion: nil)
        }
    }
    @IBAction func didTapSignUp(_ sender: UIButton) {
    }
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var usernameInput: String!
    @IBOutlet var passwordInput: String!
    @IBOutlet var usernameDatabase: String!
    @IBOutlet var passwordDatabase: String!
    
    
    @IBOutlet var tableView: UITableView!
}
