//
//  AddRecipientsViewController.swift
//  projectApp
//
//  Created by Hiro Zhu on 10/30/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

let recipients = [
    "Xubo Zhu:     xubozhu@usc.edu",
    "Hiro Zhu:     hirozhu@usc.edu",
    "Moto Zhu:     motozhu@usc.edu"
]

class AddRecipientsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBAction func didTapCancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var recipientsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        recipientsTableView.delegate = self
        recipientsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recipientsTableView.dequeueReusableCell(withIdentifier: "recipientCell", for: indexPath)
        
        cell.textLabel?.text = recipients[indexPath.row]
        return cell
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
