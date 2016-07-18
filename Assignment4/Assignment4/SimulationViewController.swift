//
//  SecondViewController.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/16/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {
    
    
    @IBOutlet weak var grid: GridView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        StandardEngine.sharedInstance.setBoard(grid.grid)
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StandardEngine.sharedInstance.delegate = self
        
        
        
        let sel = #selector(SimulationViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "EngineUpdate", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification: NSNotification){
        grid.grid = StandardEngine.sharedInstance.getBoard()
        grid.setNeedsDisplay()
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        print("update")
    }


}





