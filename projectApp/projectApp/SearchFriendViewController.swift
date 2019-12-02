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
        usernameList = []
        filteredList = []
        searchFriendButton.layer.cornerRadius = 10
        friendResultTableView.delegate = self
        friendResultTableView.dataSource = self
        friendResultTableView.isHidden = false
        for user in userDatabase{
            usernameList.append(user.username)
        }
        // Do any additional setup after loading the view.
    }
    
    var usernameList = [String]() //friend list
    var filteredList = [String]() //The actual list to be presented based on search query
    var isFriend = false
    
    @IBOutlet weak var searchFriendButton: UIButton!
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        let toSearch: String = searchBar.text ?? ""
        print(toSearch)
        filteredList = []
        for user in userDatabase{
            let curr = user.username as String
            if(curr.contains(toSearch)){
                filteredList.append(curr)
            }
        }
        friendResultTableView.reloadData()
    }
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendResultTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendResultTableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        
        
        cell.textLabel?.text = filteredList[indexPath.row]
        
        currSearchFriendPage = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "FriendSegue", sender: self)
        
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.isFriend = false
        // get a reference to the second view controller
        let friendViewController = segue.destination as! FriendViewController
        var friendHuhu = filteredList[(friendResultTableView.indexPathForSelectedRow?.row)!]
        print("Friend huhu: ", friendHuhu)
        
        friendViewController.friendName = filteredList[(friendResultTableView.indexPathForSelectedRow?.row)!]
        
        
        
        for friend in currUser.friends{
            if(filteredList[(friendResultTableView.indexPathForSelectedRow?.row)!] == friend){
                self.isFriend = true
                break
            }
        }
        friendViewController.isFriend = self.isFriend
        filteredList = []
        friendResultTableView.reloadData()
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
