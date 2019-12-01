//
//  AddCardViewController.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/12/1.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class AddCardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var cardNumberInput: UITextField!
    
    @IBAction func didTapAddCardButton(_ sender: Any) {
        let cardNumber = cardNumberInput.text
        if(cardNumber?.count != 16){
            let alert = UIAlertController(title: "Invalid Input.", message: nil, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        var newCard = "**** **** **** "
        var count = 0
        for char in cardNumber!{
            if(count >= 12){
                newCard.append(char)
            }
            count += 1
        }
        
        currUser.cards.append(newCard)
        db.collection("users").document(currUser.username).updateData([
            "cards": currUser.cards
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Cards updated")
            }
        }
        
        let alert = UIAlertController(title: "Success.", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
        currBankAccountPage.bankAccountTableView.reloadData()
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
