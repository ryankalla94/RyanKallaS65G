//
//  FirstViewController.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/16/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {
    
    @IBOutlet weak var rows: UITextField!
    
    @IBOutlet weak var cols: UITextField!
    
    @IBOutlet weak var rowsStepper: UIStepper!
    
    @IBOutlet weak var rowsChanged: UIStepper!

    @IBAction func rowsChanged(sender: UIStepper) {
        rows.text = Int(sender.value).description
    }
    
    @IBAction func colsChanged(sender: UIStepper) {
        cols.text = Int(sender.value).description
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

