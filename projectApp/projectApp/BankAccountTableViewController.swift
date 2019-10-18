//
//  BankAccountTableViewController.swift
//  practice
//
//  Created by Hiro Zhu on 10/14/19.
//  Copyright © 2019 Hiro Zhu. All rights reserved.
//

import UIKit

class BankAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cards = [
        "**** **** **** 4367",
        "**** **** **** 8734",
        "**** **** **** 3097",
        "**** **** **** 2029"
    ]

    @IBOutlet weak var bankAccountTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bankAccountTableView.delegate = self
        bankAccountTableView.dataSource = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cards.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankAccountCell", for: indexPath)

        cell.textLabel?.text = cards[indexPath.row]

        return cell
    }
}
