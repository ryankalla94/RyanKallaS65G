//
//  Problem3ViewController.swift
//  Assignment2
//
//  Created by Ryan Kalla on 7/3/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

class Problem3ViewController: UIViewController{
    
    
    @IBOutlet weak var problem3TextView: UITextView!
  
    @IBAction func problem3ButtonClicked(sender: AnyObject) {
        let board: Array<Array<Bool>> = [[Bool]](count: 5, repeatedValue: [Bool](count: 5, repeatedValue: false))
        let before: Array<Array<Bool>> = board.map{x in x.map{y in initilization()}}
        let after: Array<Array<Bool>> = step(before)
        let liveCellsBefore = numLivingCells(before)
        let liveCellsAfter = numLivingCells(after)
        problem3TextView.text = "Number of living cells before = \(liveCellsBefore)\nNumber of living cells after = \(liveCellsAfter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 3"
        
        
    }
}
