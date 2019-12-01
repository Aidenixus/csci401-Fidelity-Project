//
//  SecurityViewController.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/11/30.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class SecurityViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var currPasswordField: UITextField!
    
    @IBOutlet weak var newPasswordField: UITextField!
    
    @IBOutlet weak var reEnterPasswordField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    
    @IBAction func didTapChangePassword(_ sender: Any) {
        //Error-Checking
        let currPassword = currPasswordField.text!
        let newPassword = newPasswordField.text!
        let reEnterPassword = reEnterPasswordField.text!
        print(currPassword)
        print(newPassword)
        print(reEnterPassword)
        print("Curr: ", currUser.password)
        if(currPassword == "" || newPassword == "" || reEnterPassword == ""){
            let alert = UIAlertController(title: "Input is empty.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if (currPassword != currUser.password){
            let alert = UIAlertController(title: "Current Password is Wrong.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if(newPassword == currUser.password){
            let alert = UIAlertController(title: "Cannot use the same password.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
            
        if(newPassword != reEnterPassword){
            let alert = UIAlertController(title: "Password doesn't match.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        currUser.password = newPassword
        db.collection("users").document(currUser.username).updateData([
            "password": currUser.password
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Password updated")
            }
        }
        let alert = UIAlertController(title: "Password changed.", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
