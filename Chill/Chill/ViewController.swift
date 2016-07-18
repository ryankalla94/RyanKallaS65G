//
//  ViewController.swift
//  Chill
//
//  Created by Ryan Kalla on 7/14/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    @IBOutlet weak var nickname: UITextField!
    
    @IBAction func joinChat(sender: AnyObject) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var inputStream = NSInputStream()
    var outputStream = NSOutputStream()
    
   
    


}

