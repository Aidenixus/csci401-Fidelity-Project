//
//  LoginScreen.swift
//  projectApp
//
//  Created by Minxuan Song on 10/10/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class LoginScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        // LoginButton(<#T##sender: Any##Any#>)
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        
    }
    
    func LoginForm(username: String, password: String)
    {
        //  do query of username to password to backend now
        
        let result = -1
        // let result = verify(username,password)
        
        //  **
        if (result == 1)
        {
            // jump into the profile picture
        }
        else
        {
            //display: password/username incorrect
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
