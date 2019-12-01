//
//  FriendSettingViewController.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/11/30.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class FriendSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userFriendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendTableView.dequeueReusableCell(withIdentifier: "friend", for: indexPath)
        
        
        cell.textLabel?.text = userFriendList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.performSegue(withIdentifier: "FriendSettingSegue", sender: self)
    }
    
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        // get a reference to the second view controller
        let friendViewController = segue.destination as! FriendViewController
        friendViewController.friendName = userFriendList[(friendTableView.indexPathForSelectedRow?.row)!]

        // set a variable in the second view controller with the data to pass
//        friendViewController.friendName = filterFriendList[(friendResultTableView.indexPathForSelectedRow?.row)!]
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        friendTableView.delegate = self
        friendTableView.dataSource = self
        friendTableView.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var friendTableView: UITableView!
    var userFriendList = currUser.friends //friend list
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
