import UIKit

class BuildsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let buildContainer = Builds()
    
    @IBAction func protossButtonTapped(sender: Any){
        buildContainer.updateBuilds(race: "P")
    }
    
    @IBAction func terranButtonTapped(sender: Any){
        buildContainer.updateBuilds(race: "T")
    }
    
    @IBAction func zergButtonTapped(sender: Any){
        buildContainer.updateBuilds(race: "Z")
    }
    
    @IBAction func allButtonTapped(sender: Any){
        buildContainer.updateBuilds(race: "A")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        buildContainer.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? BuildsDetailViewController,
            let index = sender as? Int,
            let build = buildContainer.getBuild(at: index) {
            
            destination.build = build
            
        }
        
    }
}


extension BuildsViewController: BuildsDelegate {
    
    func dataUpdated() {
        tableView.reloadData()
    }
    
}

extension BuildsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let segueIdentifier = "DetailViewSegue"
        performSegue(withIdentifier: segueIdentifier, sender: indexPath.row)
    }

}

extension BuildsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildContainer.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellReuseIdentifier = "cell"
        let cell:CustomCells = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! CustomCells
        
        guard let build = buildContainer.getBuild(at: indexPath.row) else {
            return cell
        }
        
        cell.customTitleLabel.text = "\n\n" + build.matchup + " : " + build.title + "\n\n"
        return cell
    }
    
}



