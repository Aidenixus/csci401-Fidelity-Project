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

    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeholderLabel: UILabel!
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
