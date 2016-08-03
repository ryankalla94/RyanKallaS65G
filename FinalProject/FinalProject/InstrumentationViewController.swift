//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import UIKit

class InstrumentationViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    
    @IBOutlet weak var rowsTextField: UITextField!
    
    @IBOutlet weak var colsTextField: UITextField!
    
    
    @IBAction func AddGrid(sender: AnyObject) {
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "TableViewUpdate", object: nil, userInfo: ["name": "Add new grid...", "cells": []])
        center.postNotification(n)
    }
    
    
    @IBAction func rowsStepper(sender: UIStepper) {
        rowsTextField.text = Int(sender.value).description
        StandardEngine.sharedInstance.setRows = true
        StandardEngine.sharedInstance.rows = Int(rowsTextField.text!)!
    }
    
    @IBAction func colsStepper(sender: UIStepper) {
        colsTextField.text = Int(sender.value).description
        StandardEngine.sharedInstance.setCols = true
        StandardEngine.sharedInstance.cols = Int(colsTextField.text!)!
    }
    
    
    @IBAction func reloadButton(sender: AnyObject) {
        if let url: String = urlTextField.text{
            let center = NSNotificationCenter.defaultCenter()
            let n = NSNotification(name: "URLUpdate", object: nil, userInfo: ["url" : url])
            center.postNotification(n)
        }
    }
    
    @IBAction func refreshRate(sender: UISlider) {
        StandardEngine.sharedInstance.refreshRate = Double(sender.value)
    }
    
    @IBAction func autoRefresh(sender: UISwitch) {
        StandardEngine.sharedInstance.autoRefresh = sender.on
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        urlTextField.text = "https://dl.dropboxusercontent.com/u/7544475/S65g.json"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

