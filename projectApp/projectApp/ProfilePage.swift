
import UIKit


class ProfilePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
   
    
    @IBOutlet weak var balanceAmount: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockTableView: UITableView!
    
    override func viewDidLoad() {
           super.viewDidLoad()
        stockTableView.delegate = self
        stockTableView.dataSource = self

           
          ProfilePic.layer.borderWidth = 1
          ProfilePic.layer.masksToBounds = false
          ProfilePic.layer.borderColor = UIColor.black.cgColor
          ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
          ProfilePic.clipsToBounds = true
           ProfilePic.contentMode = UIView.ContentMode.scaleAspectFit
           
        balanceAmount.text = "$" + dummyUser.balance.stringValue
        nameLabel.text = dummyUser.username
        
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dummyUser.stock)
        return dummyUser.stock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stock", for: indexPath)
        
        cell.textLabel?.text = dummyUser.stock[indexPath.row]
        return cell
    }

}
