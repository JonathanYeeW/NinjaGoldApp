//
//  HighScoreScreenViewController.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit
import CoreData

class HighScoreScreenViewController: UIViewController, UITableViewDelegate {

    //Variables
    var array = [HighScoreItem]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Outlets
    @IBAction func returnButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    
    //Functions
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "HighScoreItem")
        do{
            let result = try managedObjectContext.fetch(request)
            array = result as! [HighScoreItem]
        } catch {
            print("\(error)")
        }
    }// CoreData
    func getTopScore(){
        if array.count == 0 {
            return
        } else {
            var topScore = array[0]
            for item in array {
                if item.score > topScore.score {
                    topScore = item
                }
            }
            array = [topScore]
        }
    }
    
    //ViewDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("High Score Screen View Controller")
        fetchAllItems()
        tableView.delegate = self
        tableView.dataSource = self
        getTopScore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
} //End Class

extension HighScoreScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }// Number of Rows
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "High Score Cell", for: indexPath)
        let theScore = String(array[indexPath.row].score)
        cell.detailTextLabel?.text = theScore
        return cell
    } // What's In the Cells
}
