
import UIKit

class ProfilePage: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
       ProfilePic.layer.borderWidth = 1
       ProfilePic.layer.masksToBounds = false
       ProfilePic.layer.borderColor = UIColor.black.cgColor
       ProfilePic.layer.cornerRadius = ProfilePic.frame.height/2
       ProfilePic.clipsToBounds = true
        ProfilePic.contentMode = UIView.ContentMode.scaleAspectFit
    }
    
    @IBOutlet weak var ProfilePic: UIImageView!
    
    @IBAction func SettingButton(_ sender: Any) {
        
        performSegue(withIdentifier: "mySegue", sender: self)
    }
}
