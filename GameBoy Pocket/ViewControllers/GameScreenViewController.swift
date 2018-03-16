//
//  GameScreenViewController.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class GameScreenViewController: UIViewController, EventScreenDelegate, UITableViewDelegate, CLLocationManagerDelegate {

    //Variables ####################################################################################################
    var delegate: GameScreenDelegate?
    var array = [BucketListItem]()
    var gold = 0
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!

    //Outlets ####################################################################################################
    @IBOutlet weak var distanceLabel: UILabel!
    @IBAction func quitButtonPressed(_ sender: UIBarButtonItem) {
        let counter = array.count
        var x = 0
        while x < counter {
            let item = array[0]
            managedObjectContext.delete(item)
            array.remove(at: 0)
            x += 1
        }
        let item = NSEntityDescription.insertNewObject(forEntityName: "HighScoreItem", into: managedObjectContext) as! HighScoreItem
        item.score = Int16(gold)
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        delegate?.quitButtonPressed(by: self)
    }
    @IBAction func unwind(segue: UIStoryboardSegue){}
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalGoldLabel: UILabel!
    
    //Functions ####################################################################################################
    func eventOccured(by controller: EventScreenViewController, adjective: String) {
        if adjective == "Farm" {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = "Farming"
            array.append(item)
            let newGold = Int(arc4random_uniform(11)) + 10
            gold += newGold
            item.gold = String(newGold)
        } else if adjective == "Cave" {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = "Caving"
            array.append(item)
            let newGold = Int(arc4random_uniform(6)) + 5
            gold += newGold
            item.gold = String(newGold)
        } else if adjective == "House" {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = "Housing"
            array.append(item)
            let newGold = Int(arc4random_uniform(4)) + 2
            gold += newGold
            item.gold = String(newGold)
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = "Casinoing"
            array.append(item)
            let newGold = Int(arc4random_uniform(101)) - 50
            gold += newGold
            if gold < 0 {
                gold = 0
            }
            item.gold = String(newGold)
            
        }
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        totalGoldLabel.text = String(gold)
        tableView.reloadData()
    }//Temporary fucntion to see if we can pass data from EventScreenViewController to GameScreenViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var controller = segue.destination as! EventScreenViewController
        controller.delegate = self
    }// Prepare segue to event screen
    
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do{
            let result = try managedObjectContext.fetch(request)
            array = result as! [BucketListItem]
        } catch {
            print("\(error)")
        }
    }// CoreData
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let latestLocation: CLLocation = locations[locations.count - 1]
        if startLocation == nil { startLocation = latestLocation }
        let distanceBetween: CLLocationDistance = latestLocation.distance(from: startLocation)
        distanceLabel.text = String(format: "%.2f", distanceBetween)
        if let dist = Double(distanceLabel.text!){
            if(dist > 8){
                print("SUCCESS")
                performSegue(withIdentifier: "Action Segue", sender: self)
                startLocation = nil
            }
        }
    } // Location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}//Location

    //ViewDidLoad() ####################################################################################################
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Game Screen View Controller")
        tableView.dataSource = self
        tableView.delegate = self
        fetchAllItems()
        totalGoldLabel.text = String(gold)
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        startLocation = nil
        var x = 0
        let counter = array.count
        while x < counter {
            let item = array[0]
            managedObjectContext.delete(item)
            array.remove(at: 0)
            x += 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
} // End Class

extension GameScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }// number of rows in my table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].text
        cell.detailTextLabel?.text = array[indexPath.row].gold
        return cell
    }
}
