import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    @IBOutlet weak var spawningtoolLabel: UILabel!
    
    @IBAction func sourceButtonPressed(_ sender: Any){
        UIApplication.shared.open(URL(string: "https://lotv.spawningtool.com/")! as URL, options: [:], completionHandler: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Starcraft 2 Build Order Timer"
        spawningtoolLabel.text = "Build data from Spawning Tool"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginTapped(_ sender: Any){
        performSegue(withIdentifier: "Login", sender: (Any).self)
    }


}

