//
//  SearchFriendViewController.swift
//  projectApp
//
//  Created by Hiro Zhu on 10/18/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

let dummySearchFriendResult = ["Lucas Zhu", "Adam Zhu", "Hiro Zhu", "Taka Zhu"]

class SearchFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        friendResultTableView.delegate = self
        friendResultTableView.dataSource = self
        friendResultTableView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        if (searchBar.text == "Zhu") {
            friendResultTableView.isHidden = false
        } else{
            friendResultTableView.isHidden = true
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendResultTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummySearchFriendResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendResultTableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        
        
        cell.textLabel?.text = dummySearchFriendResult[indexPath.row]
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
