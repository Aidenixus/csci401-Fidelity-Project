//
//  FriendViewController.swift
//  projectApp
//
//  Created by Tianxing Liu on 2019/11/29.
//  Copyright © 2019 Minxuan Song. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var friendStockTableView: UITableView!
    
    @IBOutlet weak var addFriendButton: UIButton!
    var friendName = ""
    var currFriend = User()
    override func viewDidLoad() {
        super.viewDidLoad()
        print(friendName)
        friendStockTableView.delegate = self
        friendStockTableView.dataSource = self
        for user in userDatabase{
            if(friendName == user.username){
                currFriend = user
                break
            }
        }
        
        if(currFriend.username == "TommyTrojan"){
            ProfilePic.image = UIImage(named: "TommyTrojan")
        }
        else{
            ProfilePic.image = UIImage(named: "three")
        }

        ProfilePic.layer.borderWidth = 1
        ProfilePic.layer.masksToBounds = false
        ProfilePic.layer.borderColor = UIColor.black.cgColor
        ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
        ProfilePic.clipsToBounds = true
        ProfilePic.contentMode = UIView.ContentMode.scaleAspectFit
        nameLabel.text = currFriend.username
//
//
    }
    @IBAction func didTapAddFriendButton(_ sender: Any) {
        currUser.friends.append(currFriend.username)
        db.collection("users").document(currUser.username).updateData([
            "friends": currUser.friends
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Friend added")
            }
        }
        
        //TODO: Unexpectedlly found nil while reloading empty tableview
        currSearchFriendPage.viewDidLoad()
        
    }
//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(currFriend.stock)
        return currFriend.stock.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = friendStockTableView.dequeueReusableCell(withIdentifier: "stock", for: indexPath)

        var arrayStock = [String]()
        for i in currFriend.stock{
            arrayStock.append(i.key)
        }

        cell.textLabel?.text = arrayStock[indexPath.row]

        return cell
    }
    

}
