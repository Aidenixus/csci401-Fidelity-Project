import UIKit

var currProfilePage = ProfilePage()


class ProfilePage: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var investmentBalanceAmount: UILabel!
    @IBOutlet weak var balanceAmount: UILabel!
    @IBOutlet weak var ProfilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stockTableView: UITableView!
    @IBOutlet weak var ProfileTopButton: UIBarButtonItem!
    @IBOutlet weak var PayTopButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTableView.delegate = self
        stockTableView.dataSource = self
        
        if(currUser.username == "TommyTrojan"){
            ProfilePic.image = UIImage(named: "TommyTrojan")
        }
        else if (currUser.username == "PeterMin"){
            ProfilePic.image = UIImage(named: "three")
        }
        else{
            ProfilePic.image = UIImage(named: "question")
        }
        
        ProfilePic.layer.borderWidth = 1
        ProfilePic.layer.masksToBounds = false
        ProfilePic.layer.borderColor = UIColor.black.cgColor
        ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
        ProfilePic.clipsToBounds = true
        ProfilePic.contentMode = UIView.ContentMode.scaleAspectFit
           
        balanceAmount.text = "$" + currUser.balance.stringValue
        nameLabel.text = currUser.username
        investmentBalanceAmount.text = "$" + currUser.investmentBalance.stringValue
        currProfilePage = self
        // changing font
        ProfileTopButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Futura", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
        for: .normal)
        PayTopButton.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont(name: "Menlo", size: 17.0)!,
            NSAttributedString.Key.foregroundColor: UIColor.black],
        for: .normal)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(currUser.stock)
        return currUser.stock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "stock", for: indexPath)
        
        var arrayStock = [String]()
        for i in currUser.stock{
            arrayStock.append(i.key + "   " + String(i.value))
        }
        
        cell.textLabel?.text = arrayStock[indexPath.row]
        
        
        
        return cell
    }

}
