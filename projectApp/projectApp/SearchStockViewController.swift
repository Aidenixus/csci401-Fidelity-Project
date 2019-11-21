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
    
    @IBOutlet weak var input: UISearchBar!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            var SearchTextInfo = segue.destination as! DisplayStockInfoViewController
        if(input.text == ""){
            //TODO: Add error message
            SearchTextInfo.searchInput = "Error"
        }
        else {
            SearchTextInfo.searchInput = input.text!
        }
    }
    
    @IBOutlet weak var searchStockButton: UIButton!
    
    @IBAction func didTapSearchStock(_ sender: UIButton) {
        performSegue(withIdentifier: "stockSegue" , sender: self)
    }
}
