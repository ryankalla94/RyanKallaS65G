//
//  ViewController.swift
//  Lecture3
//
//  Created by Ryan Kalla on 6/27/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: UITextView!
    @IBAction func buttonClicked(sender: AnyObject) {
        print ("We were clicked")
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

