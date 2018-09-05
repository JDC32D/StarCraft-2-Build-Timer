//
//  BuildViewController.swift
//  StarCraft 2 Build Timer
//
//  Created by Joe Carmody  on 7/25/18.
//  Copyright © 2018 Joe Carmody . All rights reserved.
//

//import Foundation
import UIKit

class BuildViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let builds = Builds()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        model.delegate = self
    }

}

let build = Builds()

extension BuildsViewController: BuildDelegate {
    
    func dataUpdated() {
        tableView.reloadData()
    }
    
}

//extension BuildsViewController: UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let segueIdentifier = "showMovieDetail"
//        performSegue(withIdentifier: segueIdentifier, sender: indexPath.row)
//    }
//
//}

extension BuildsViewController: UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return builds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellReuseIdentifier = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        guard let build = builds.build(at: indexPath.row) else {
            return cell
        }
        
        cell.textLabel?.text = build.title
        //When turning data from Int to String can use this cast
        //cell.detailTextLabel?.text = String(movie.year)
        cell.matchupTextLabel?.text = build.matchup
        return cell
    }
    
}



