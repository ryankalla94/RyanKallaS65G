//
//  ViewController.swift
//  Lecture12
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    
    @IBAction func alert(sender: AnyObject) {
        let alert = UIAlertController(title: "MyAlert", message: "This is an alert", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Title1", style: .Default) { _ in self.textField.text = "alert was pressed"})
        self.presentViewController(alert, animated: true) {}
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

