//
//  StockDetailPage.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/10/17.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class StockDetailPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        buyButton.layer.cornerRadius = 20
        sellButton.layer.cornerRadius = 20

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var sellButton: UIButton!

    
    
    @IBAction func didTapBuy(_ sender: UIButton) {
        //  todo
    }
    
    
    @IBAction func didTapSell(_ sender: UIButton) {
        //  todo
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
