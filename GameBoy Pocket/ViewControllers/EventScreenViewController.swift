//
//  EventScreenViewController.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
import CoreLocation

class EventScreenViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate {

    let locationManager = CLLocationManager()
    
    //Starwars API
    var character: String = ""
    @IBOutlet weak var textLabel: UILabel!
    
    //Variables
    var delegate: EventScreenDelegate?
    var text: String?
    var locations = ["Farm", "Cave", "House", "Casino"]
    var locationDescriptions = ["Would You like to Duel?", "Would You like to Duel?", "Would You like to Duel?", "Would You like to Duel?"]
    
    
    
    //Outlets
    @IBOutlet weak var descriptionLable: UILabel!
   
    @IBAction func passButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        delegate?.eventOccured(by: self, adjective: text!)
    }
    
    @IBOutlet weak var tableView: UITableView!
    //Functions
    //ViewDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        let ranNumber = arc4random_uniform(4)
        text = locations[Int(ranNumber)]
        
        descriptionLable.text = locationDescriptions[Int(ranNumber)]
        
        //Star Wars API
        let url = URL(string: "http://swapi.co/api/people/" + String(arc4random_uniform(86) + 1))
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: {
            data, response, error in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let name = jsonResult["name"] {
                        self.character = name as! String
                        print(self.character)
                        self.textLabel.text = self.character
                    }
                    DispatchQueue.main.async {
                        self.textLabel.setNeedsDisplay()
                    }
                }
            }
            catch {
                print("\(error)")
            }
        })
        task.resume()
        print(url!)
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
