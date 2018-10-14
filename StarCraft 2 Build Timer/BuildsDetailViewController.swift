//
//  BuildsDetailViewController.swift
//  StarCraft 2 Build Timer
//
//  Created by Joe Carmody  on 8/1/18.
//  Copyright © 2018 Joe Carmody . All rights reserved.
//

import UIKit
class BuildsDetailViewController: UIViewController {
    
    @IBOutlet weak var buildTitleLabel: UILabel!
    @IBOutlet weak var buildDescriptionTextView: UITextView!
    @IBOutlet weak var buildOrderTextView: UITextView!
    @IBOutlet weak var videoLinkButton: UIButton!

    //YouTube link button
    @IBAction func videoButtonPressed(_ sender: Any){
        if build!.video == "NoVideoAvailable" {
            videoLinkButton.isEnabled = false
            return
        }
        UIApplication.shared.open(URL(string: "\(build!.video)")! as URL, options: [:], completionHandler: nil)
    }
    
    //Spawning Tool / Source Button
    @IBAction func sourceButtonPressed(_ sender: Any){
        UIApplication.shared.open(URL(string: "\(build!.link)")! as URL, options: [:], completionHandler: nil)
    }
    
    var build: Build?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let build = self.build else { return }
        buildTitleLabel.text = build.title
        buildDescriptionTextView.text = build.description
        buildOrderTextView.text = build.getBuildDetailDisplay()
        videoLinkButton.isEnabled = true
    }
    
//    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == timerSegueIdentifier,
//            let destination = segue.destinationViewController as? TimerViewController,
//            buildIndex = tableView.indexPathForSelectedRow?.row
//        {
//            destination.build = build[blogIndex]
//        }
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is TimerViewController {
            let destination = segue.destination as! TimerViewController

            destination.build = build
        }

    }
    
}


