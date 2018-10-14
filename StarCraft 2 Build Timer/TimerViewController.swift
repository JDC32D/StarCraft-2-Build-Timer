//Source: https://www.ios-blog.com/tutorials/swift/swift-timer-tutorial-create-a-counter-timer-application-using-nstimer/

import Foundation
import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var countingLabel: UILabel!
    @IBOutlet weak var buildTextView: UITextView!
    @IBOutlet weak var buildTitleLabel: UILabel!
    @IBOutlet var playButton: UIBarButtonItem!
    @IBOutlet var pausebutton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard self.build != nil else { return }
        countingLabel.text = startString
        buildTitleLabel.text = build!.title
    }
    
    var build: Build?
    //var buildDisplay: BuildQueue?
    
    //Variables used for timekeeping
    var SwiftTimer = Timer()
    var timerOutputString = ""
    var startString = "0:00"
    var secondsCounter = 0
    var tensCounter = 0
    var minutesCounter = 0
    
    //Variables used for build output
    var list = [String]()
    
    @IBAction func startButton(sender: AnyObject) {
        
        SwiftTimer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        playButton.isEnabled = false //Dont remove this line, 2 timers could start at once
        
    }
    
    @IBAction func pauseButton(sender: AnyObject) {
        SwiftTimer.invalidate()
        playButton.isEnabled = true
    }
    
    @IBAction func clearButton(sender: AnyObject) {
        SwiftTimer.invalidate()
        resetCounters()
        countingLabel.text = startString
        buildTextView.text = " "
        playButton.isEnabled = true
    }
    
    @objc func updateCounter() {
        secondsCounter = secondsCounter + 1
        
        //Increment tens of seconds
        if secondsCounter == 10 {
            secondsCounter = 0
            tensCounter = tensCounter + 1
        }
        //Increment minutes
        if tensCounter == 6 {
            tensCounter = 0
            minutesCounter = minutesCounter + 1
        }
        
        //updateTextField and updateCounter
        timerOutputString = String(minutesCounter) + ":" + String(tensCounter) + String(secondsCounter)
        countingLabel.text = timerOutputString
        getBuildDisplay()
    }
    
    func resetCounters(){
        secondsCounter = 0
        tensCounter = 0
        minutesCounter = 0
    }
    
    //Appends build time and action to list, if appropriate
    func getBuildDisplay(){
        for index in 0...(build!.time.count - 1){
            if timerOutputString == build!.time[index]{
                list.append("\(build!.time[index]) : \(build!.action[index])\n")
                updateBuildTextView()
            }
        }
    }
    
    //Updates text view by handling the size of list
    func updateBuildTextView(){
        buildTextView.text = buildTextView.text + (list.last ?? "nil found")
        if list.count % 5 == 0 && list.count != 0 {
            buildTextView.text = "" + (list.last ?? "nil found")
            //print("clearing text view")
        }
        
    }
    


}
