/*
 Personal comments for adding builds later:
     "Title" : "",
     "Race" : "",
     "Matchup": "",
     "Link" : "",
     "Video" : "",
     "Description" : "",
 
     Converting HTML to JSON: http://convertjson.com/html-table-to-json.htm
 
     To grab raw HTML data:
        Navigate to the build
        Open the console
        Go to Inspector
        Search for #build-1
        Right click that line -> copy outer HTML -> paste into conversion site
*/
/*
 
======= Final Project | Joseph Carmody | JDC32D ======
 
>------Proposal Objectives---------<
 Not implemented:
    -Pulling build data right from SpawningTool's site
    -Users, saving Favorite Builds
 
 Implemented:
    -Table of builds
    -Detailed view with description and entire build order with supply
    -Buttons linking to SpawningTool
    -Button linking to video of build(if available from author of build)
    -A timer view that displays when to perform an action, once you tap start
 
>------Technical Requirements------<
 MVC Structure
    -Model class which handles busniess/domain/problem logic
 
 Auto Layout
    -I have some auto layout constraints to keep things in place.
    -The buttons and images seem to go crazy at times, I will be working on this until submission time
 
 Multiple Screens
    -I have over 3 view controllers and all pages can be navigated from
    -UINavigationController is used
    -TableView is used in BuildsViewController
        -I do not have the ability to delete or add rows in TableView. It does not really make sense for the user to delete content because they couldnt add it back and typing up a build without a physical keyboard would be...painful. I wanted to do something that shows I know how to change the table once its loaded. So, I added filters, now the user can search through each race to find a build for each matchup.
 
UIElements
    -UILabel, UIButton, UITextField, and a few others are used
 
 Other Frameworks and Technologies
    -I have used UIApplication to have some buttons open the link in a web browser
    -My app uses Timer to display data in TimerView
    -I also made a toolbars for TimerViewController and BuildsViewController
 
>------Problems & Solutions/Sources-------<
 
 (Not in any particular order)
 P: Parsing JSON data
 S: https://www.hackingwithswift.com/read/7/3/parsing-json-loading-data-into-swiftyjson
 
 P: I am using UIScrollView wrong
 S: https://www.youtube.com/watch?v=nfHBCQ3c4Mg
    I was using it very, very wrong
 
 P: I need to work with the timer, preferably without having to worry about threading
 S: https://www.ios-blog.com/tutorials/swift/swift-timer-tutorial-create-a-counter-timer-application-using-nstimer/

 Modified functions/files/classes from ExampleApp6
 -JSONReader
 -MovieModel
 -MovieDetail
 
 */
import Foundation

struct Build {
    var title: String
    var race: String
    var matchup: String
    var link: String
    var video: String
    var description: String
    var supply = [String]()
    var time = [String]()
    var action = [String]()
    
    func getBuildDetailDisplay() -> String {
        var outputString = ""
        for index in 0...(time.count - 1){
            outputString = outputString + ("\(supply[index]) \(action[index])\n")
        }
        return outputString
    }

}

protocol BuildsDelegate: class {
    func dataUpdated()
}

class Builds {
    
    var buildOrders = [Build]()
    var userDefinedBuilds = [Build]()
    //var allBuilds = [Build]()
    
    weak var delegate: BuildsDelegate?
    
    init() {
        guard let buildJson = JsonReader.jsonArray(fromFile: "builds") else { return }
        buildOrders = buildJson.compactMap { Build.from(json: $0) }
        delegate?.dataUpdated()
    }
    
    var count: Int {
        return buildOrders.count
    }
    
    func getBuild(at index: Int) -> Build? {
        return buildOrders.element(at: index)
    }
    
    func updateBuilds(race: String) {
        //Reset container for filtering builds
        userDefinedBuilds = [Build]()
        guard let buildJson = JsonReader.jsonArray(fromFile: "builds") else { return }
        buildOrders = buildJson.compactMap { Build.from(json: $0) }
        delegate?.dataUpdated()
        switch race {
            case "A": //Display all races
                return
            case "P": //Display only Protoss
                for build in buildOrders {
                    if build.race == "P" {
                        userDefinedBuilds.append(build)
                    }
                }
                buildOrders = userDefinedBuilds
                delegate?.dataUpdated()
            
            case "T": //Display only Terran
                for build in buildOrders {
                    if build.race == "T" {
                        userDefinedBuilds.append(build)
                    }
                }
            buildOrders = userDefinedBuilds
            delegate?.dataUpdated()
        
            case "Z": //Display only Zerg
                for build in buildOrders {
                    if build.race == "Z" {
                        userDefinedBuilds.append(build)
                    }
                }
            buildOrders = userDefinedBuilds
            delegate?.dataUpdated()
            
            default: 
                print("Error in race filtering")
            
        }
    }
    
}

extension Build {
    
    static func from(json: JsonDictionary) -> Build? {
        
        guard let title = json["Title"] as? String,
            let race = json["Race"] as? String,
            let matchup = json["Matchup"] as? String,
            let link = json["Link"] as? String,
            let video = json["Video"] as? String,
            let description = json["Description"] as? String,
            let supply = json["Supply"] as? [String],
            let time = json["Time"] as? [String],
            let action = json["Action"] as? [String]
            else {
                print("couldnt read build")
                return nil
            }
        
        return Build(title: title, race: race, matchup: matchup, link: link, video: video, description: description, supply: supply, time: time, action: action)
    }
    
}

extension Array {
    
    func element(at index: Int) -> Element? {
        if index < 0 || index >= self.count { return nil }
        return self[index]
    }
    
}
