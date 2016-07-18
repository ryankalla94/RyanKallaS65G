//
//  ViewController.swift
//  Lecture6
//
//  Created by Ryan Kalla on 7/11/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ExampleDelegateProtocol {

    @IBOutlet weak var rows: UITextField!
    
    var example: ExampleProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        example = Example.sharedInstance
        example.delegate = self
        
        // notifications
        let sel = #selector(ViewController.watchForNotifications(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "ExampleNotification", object: nil)
    }
    
    func watchForNotifications(notification: NSNotification){
        print("notification")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateTimeInterval(sender: UITextField) {
        if let text = sender.text, interval = Double(text) {
            example.refreshInterval = interval
        } else {
            example.refreshInterval = 0
        }
    }
    
    @IBAction func increment(sender: AnyObject) {
        example.rows += 10
    }
    
    func example(e: Example, didUpdateRows: UInt) {
        rows.text = String(didUpdateRows)
    }

}

