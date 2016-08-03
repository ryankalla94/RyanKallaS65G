//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class SimulationViewController: UIViewController, EngineDelegateProtocol {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var grid: GridView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        StandardEngine.sharedInstance.setBoardWithoutNotification(grid.grid)
        StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
        grid.grid = StandardEngine.sharedInstance.getBoard()
        grid.setNeedsDisplay()
        
        //StandardEngine.sharedInstance.autoRefresh = !StandardEngine.sharedInstance.autoRefresh
    }
    
    @IBAction func reset(sender: AnyObject) {
        StandardEngine.sharedInstance.grid = Grid(rows: grid.rows, cols: grid.cols)
        grid.grid = StandardEngine.sharedInstance.getBoard()
        grid.setNeedsDisplay()
    }

    @IBAction func save(sender: AnyObject) {
        let name = textField.text!
        guard name != ""
            else{
                let alert = UIAlertController(title: "Cannot Save", message: "Grid needs a title", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default) { _ in self.textField.text = ""})
                self.presentViewController(alert, animated: true) {}
                return
        }
        func newCells() -> [[Int]] {
            var cells: [[Int]] = []
            for x in 0..<grid.rows{
                for y in 0..<grid.cols{
                    if grid.grid[x][y] == .Living{
                        cells.append([x,y])
                    }
                }
            }
            return cells
        }
        let cells = newCells()
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "TableViewUpdate", object: nil, userInfo: ["name": name, "cells": cells])
        center.postNotification(n)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        StandardEngine.sharedInstance.delegate = self
        
        let sel = #selector(SimulationViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "EngineUpdate", object: nil)
        
        let sel2 = #selector(SimulationViewController.watchForSizeNotifications(_:))
        let center2 = NSNotificationCenter.defaultCenter()
        center2.addObserver(self, selector: sel2, name: "SizeUpdate", object: nil)
        
        let sel3 = #selector(SimulationViewController.watchForTimeNotifications(_:))
        let center3 = NSNotificationCenter.defaultCenter()
        center3.addObserver(self, selector: sel3, name: "TimerUpdate", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func watchForNotifications(notification: NSNotification){
        grid.rows = StandardEngine.sharedInstance.rows
        grid.cols = StandardEngine.sharedInstance.cols
        grid.grid = StandardEngine.sharedInstance.getBoard()
    }
    
    func watchForSizeNotifications(notification: NSNotification){
        let rowSize = notification.userInfo!["rows"] as! Int
        let colSize = notification.userInfo!["cols"] as! Int
        grid.rows = rowSize
        grid.cols = colSize
        //grid.grid = StandardEngine.sharedInstance.getBoard()
        grid.setNeedsDisplay()
    }
    
    func watchForTimeNotifications(notification: NSNotification){
        if StandardEngine.sharedInstance.autoRefresh {
            StandardEngine.sharedInstance.setBoardWithoutNotification(grid.grid)
            StandardEngine.sharedInstance.grid = StandardEngine.sharedInstance.step()
            grid.grid = StandardEngine.sharedInstance.getBoard()
            grid.setNeedsDisplay()
        }
    }
    
    func engineDidUpdate(withGrid: GridProtocol) {
        //grid.grid = StandardEngine.sharedInstance.getBoard()
        grid.setNeedsDisplay()
    }


}

