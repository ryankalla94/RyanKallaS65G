//
//  ViewController.swift
//  Assignment3
//
//  Created by Ryan Kalla on 7/9/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var grid: GridView!
    
    @IBAction func buttonPressed(sender: AnyObject) {
        grid.grid = grid.step2(grid.grid)
        grid.setNeedsDisplay()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

