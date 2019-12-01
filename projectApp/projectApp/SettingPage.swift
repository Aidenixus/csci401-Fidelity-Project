//
//  SettingPage.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/10/10.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class SettingPage: UIViewController {

    @IBOutlet weak var logoutButton: UIButton!
    @IBAction func didTapLogout(_ sender: Any) {
        currUser = User()
        for users in userDatabase{
            print(users.username + ": ")
            print(users.balance)
            print(users.investmentBalance)
            print("")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
