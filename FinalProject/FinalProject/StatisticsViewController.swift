//
//  StatisticsViewController.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

import UIKit

class StatisticsViewController: UIViewController {
    
    @IBOutlet weak var bornCells: UILabel!
    
    @IBOutlet weak var livingCells: UILabel!
    
    @IBOutlet weak var diedCells: UILabel!
    
    @IBOutlet weak var emptyCells: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        bornCells.text = "Number of Born cells = \(countCellType(.Born))"
        livingCells.text = "Number of Living cells = \(countCellType(.Living))"
        diedCells.text = "Number of Died cells = \(countCellType(.Died))"
        emptyCells.text = "Number of Empty cells = \(countCellType(.Empty))"
        let sel = #selector(SimulationViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "StatUpdate", object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countCellType(type: CellState) -> Int {
        var count = 0
        for x in 0 ..< StandardEngine.sharedInstance.rows{
            for y in 0 ..< StandardEngine.sharedInstance.cols{
                if StandardEngine.sharedInstance.grid[x,y] == type{
                    count += 1
                }
            }
        }
        return count
    }
    
    func watchForNotifications(notification: NSNotification){
        bornCells.text = "Number of Born cells = \(countCellType(.Born))"
        livingCells.text = "Number of Living cells = \(countCellType(.Living))"
        diedCells.text = "Number of Died cells = \(countCellType(.Died))"
        emptyCells.text = "Number of Empty cells = \(countCellType(.Empty))"
    }
    
    
}