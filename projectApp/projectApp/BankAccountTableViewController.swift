//
//  BankAccountTableViewController.swift
//  practice
//
//  Created by Hiro Zhu on 10/14/19.
//  Copyright © 2019 Hiro Zhu. All rights reserved.
//

import UIKit

class BankAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var bankAccountTableView: UITableView!
    @IBAction func didTapCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        bankAccountTableView.delegate = self
        bankAccountTableView.dataSource = self

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currUser.cards.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bankAccountCell", for: indexPath)

        cell.textLabel?.text = currUser.cards[indexPath.row]

        return cell
    }
}
