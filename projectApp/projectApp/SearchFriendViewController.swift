//
//  SearchFriendViewController.swift
//  projectApp
//
//  Created by Hiro Zhu on 10/18/19.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

var currSearchFriendPage = SearchFriendViewController()

class SearchFriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        userFriendList = []
        filterFriendList = []
        searchFriendButton.layer.cornerRadius = 10
        friendResultTableView.delegate = self
        friendResultTableView.dataSource = self
        friendResultTableView.isHidden = false
        for friends in currUser.friends{
            userFriendList.append(friends)
        }
        filterFriendList = userFriendList
        // Do any additional setup after loading the view.
    }
    
    var userFriendList = [String]() //friend list
    var filterFriendList = [String]() //The actual list to be presented based on search query
    
    @IBOutlet weak var searchFriendButton: UIButton!
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        let toSearch: String = searchBar.text ?? ""
        print(toSearch)
        if(toSearch == ""){
            filterFriendList = userFriendList
        }
        else{
            filterFriendList = []
            for user in userDatabase{
                let curr = user.username as String
                if(curr.contains(toSearch)){
                    filterFriendList.append(curr)
                }
            }
        }
        friendResultTableView.reloadData()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendResultTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterFriendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendResultTableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        
        
        cell.textLabel?.text = filterFriendList[indexPath.row]
        
        currSearchFriendPage = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "FriendSegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let friendViewController = segue.destination as! FriendViewController
        friendViewController.friendName = filterFriendList[(friendResultTableView.indexPathForSelectedRow?.row)!]

        // set a variable in the second view controller with the data to pass
//        friendViewController.friendName = filterFriendList[(friendResultTableView.indexPathForSelectedRow?.row)!]
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
