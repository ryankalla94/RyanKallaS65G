//
//  EditViewController.swift
//  Lecture8
//
//  Created by Ryan Kalla on 7/20/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

class EditViewController: UIViewController{
    
    var name: String?
    var commit: (String -> Void)?
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = nameTextField.text, commit = commit
            else{
                return
        }
        commit(newText)
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameTextField.text = name
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
