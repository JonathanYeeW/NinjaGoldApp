//
//  StartScreenViewController.swift
//  GameBoy Pocket
//
//  Created by Jonathan Yee on 3/15/18.
//  Copyright © 2018 Jonathan Yee. All rights reserved.
//

import UIKit


class StartScreenViewController: UIViewController, GameScreenDelegate {

   
    //Variables
    //Outlets
    //Functions
    func quitButtonPressed(by controller: GameScreenViewController) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Game Start"{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! GameScreenViewController
            controller.delegate = self
        }
    }
    //ViewDidLoad()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start Screen View Controller")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
