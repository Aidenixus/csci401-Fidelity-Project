//
//  SearchStockViewController.swift
//  projectApp
//
//  Created by Minxuan Song on 10/18/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class SearchStockViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        searchStockButton.layer.cornerRadius = 10

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var searchStockButton: UIButton!
    
    @IBAction func didTapSearchStock(_ sender: UIButton) {
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
