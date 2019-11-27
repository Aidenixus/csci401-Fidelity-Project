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
    var stock: [String: Int]
    var friends: [String]
    var cards: [String]
    var investmentBalance: NSNumber
    
    init(username: String, password: String, balance: NSNumber, stock: [String: Int], friends: [String], cards: [String], investmentBalance: NSNumber){
        self.username = username
        self.password = password
        self.balance = balance
        self.stock = stock
        self.friends = friends
        self.cards = cards
        self.investmentBalance = investmentBalance
    }
    init(){
        self.username = ""
        self.password = ""
        self.balance = 0
        self.stock = [String: Int]()
        self.friends = []
        self.cards = []
        self.investmentBalance = 0
    }
}

var currUser: User = User()
var userDatabase: [User]!

class LoginViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Mysterious Code
        LoadFromDatabase (completion: { dataUsers in
            userDatabase = dataUsers
        })
        //Mysterious Code
    }
    //Login Button
    @IBOutlet weak var loginButton: UIButton!
    //Signup Button
    @IBOutlet weak var signUpButton: UIButton!
    
    
    func LoadFromDatabase(completion: @escaping([User])->Void )
    {
        
        var dataUsers : [User] = []
        db.collection("users").getDocuments { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let dataUser = User(username: document.get("name") as! String, password: document.get("password") as! String, balance: document.get("balance") as! NSNumber, stock: document.get("stock") as! [String: Int], friends: document.get("friends") as! [String], cards: document.get("cards") as! [String], investmentBalance: document.get("investmentBalance") as! NSNumber)
                    dataUsers.append(dataUser)
                }
                completion(dataUsers)
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
        
        for users in userDatabase{
            if(self.usernameInput == users.username && self.passwordInput == users.password){
                currUser = users //The current user for this session is set
                verified = true
                break
            }
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
    
    
    
    
    @IBOutlet var tableView: UITableView!
}
