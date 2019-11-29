//
//  PayViewController.swift
//  projectApp
//
//  Created by Hiro Zhu on 11/16/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class PayViewController: UIViewController, UITextViewDelegate {
    
    var receivedData = ""
    var placeHolderText = "  What😀's it for🍔🍟🌭💍💌🎁💰❓"
    var investAmount = 0.0
    var payAmount = 0.0

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        messageTextView.delegate = self
        placeholderLabel.text = placeHolderText
        placeholderLabel.textColor = .lightGray
        placeholderLabel.layer.zPosition = 100
        recipientLabel.text = receivedData
        // Do any additional setup after loading the view.
    }
    
    func textViewDidChange(_ textView: UITextView) {
      let newAlpha: CGFloat = messageTextView.text.isEmpty ? 1 : 0
      if placeholderLabel.alpha != newAlpha {
        UIView.animate(withDuration: 0.3) {
          self.placeholderLabel.alpha = newAlpha
        }
      }
    }

    @IBAction func didTapPayButton(_ sender: UIButton) {
        if (amountTextField.text == "") {
            showAlertIfNumberIsEmpty()
        } else if (messageTextView.text == "") {
            showAlertIfMessageIsEmpty()
        } else {
            let investAmount = 0.1 * Double(amountTextField.text!)!
            let alert = UIAlertController(title: "", message: "Would you like to put 10% of this transaction (💲\(String(format:"%.02f", investAmount))) into your investment account?", preferredStyle: UIAlertController.Style.actionSheet)

            alert.addAction(UIAlertAction(title: "Yes🐷!", style: UIAlertAction.Style.default, handler: {(action) in self.showConfirmationAlert(invest: true)}))
            alert.addAction(UIAlertAction(title: "Not this time", style: UIAlertAction.Style.default, handler: {(action) in self.showConfirmationAlert(invest: false)}))

            alert.addAction(UIAlertAction(title: "❌", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
               
            }))


            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showConfirmationAlert(invest: Bool) {
        payAmount = Double(amountTextField.text!)!
        var messageToShow = "You will pay xxxxx 💲\(payAmount), and invest💲0.00 into your Fidelity account."
        if (invest) {
            investAmount = 0.1 * payAmount
            messageToShow = "You will pay xxxxx 💲\(payAmount), and invest💲\(String(format:"%.02f", investAmount)) into your Fidelity account."
        }
        let alert = UIAlertController(title: nil, message: messageToShow, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Discard", style: UIAlertAction.Style.destructive, handler: nil ))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in
            self.dismiss(animated: true, completion: nil)
            //1. Modify Local changes
            //a. Local self balance
            var currUserBalance = Double(currUser.balance)
            currUserBalance -= self.payAmount
            currUser.balance = NSNumber(value: currUserBalance)
            print(currUser.balance)
            //b. Local recipient balance
            print(self.receivedData)
            var recipientBalance = 0.0
            for user in userDatabase{
                if(user.username == self.receivedData){
                    print("huhu")
                    recipientBalance = Double(user.balance)
                    recipientBalance += self.payAmount
                    user.balance = NSNumber(value: recipientBalance)
                }
            }
            //c. Local investmentBalance
            var currUserInvest = 0.0
            if(invest){
                currUserInvest = Double(currUser.investmentBalance)
                currUserInvest += self.investAmount
                currUser.investmentBalance = NSNumber(value: currUserInvest)
            }
            //2. Modify database changes
            //a. Database self balance
            db.collection("users").document(currUser.username).updateData([
                "balance": currUserBalance
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("User balance dropped")
                    }
                }
            //b. Database recipient balance
            db.collection("users").document(self.receivedData).updateData([
                "balance": recipientBalance
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Recipient balance increased")
                    }
                }
            //c. Database self investment
            if(invest){
                db.collection("users").document(currUser.username).updateData([
                "investmentBalance": currUserInvest
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Investment balance increased")
                    }
                }
            }
            currProfilePage.viewDidLoad()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertIfMessageIsEmpty() {
        let alert = UIAlertController(title: "Please enter a message.", message: "Such as: 🍩, 🎤, or 🏂?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertIfNumberIsEmpty() {
        let alert = UIAlertController(title: nil, message: "Please enter a 💲amount.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)

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
