//
//  AddRecipientsViewController.swift
//  projectApp
//
//  Created by Hiro Zhu on 10/30/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

let recipients = currUser.friends

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
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // Segue to the second view controller
        self.performSegue(withIdentifier: "paySegue", sender: self)
    }

    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let payViewController = segue.destination as! PayViewController

        // set a variable in the second view controller with the data to pass
        payViewController.receivedData = recipients[(recipientsTableView.indexPathForSelectedRow?.row)!]
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
