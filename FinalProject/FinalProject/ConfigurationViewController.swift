//
//  ConfigurationViewController.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

class ConfigurationViewController: UITableViewController {
    
    private var names: [String] = []
    private var gridCells: [[[Int]]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = NSURL(string: "https://dl.dropboxusercontent.com/u/7544475/S65g.json")
        let fetcher = Fetcher()
        fetcher.requestJSON(url!) { (json, message) in
            if let json = json, dict = json as? [Dictionary<String,AnyObject>] {
                self.names = dict.map { $0["title"] as! String }
                self.gridCells = dict.map { ($0["contents"]! as! [[Int]]) }
                let op = NSBlockOperation {
                    self.tableView.reloadData()
                }
                NSOperationQueue.mainQueue().addOperation(op)
            }
        }
        
        let sel = #selector(ConfigurationViewController.reloadTable(_:))
        let center = NSNotificationCenter.defaultCenter()
        center.addObserver(self, selector: sel, name: "URLUpdate", object: nil)
        
        let sel2 = #selector(ConfigurationViewController.addTableCell(_:))
        let center2 = NSNotificationCenter.defaultCenter()
        center2.addObserver(self, selector: sel2, name: "TableViewUpdate", object: nil)
    }
    
    func reloadTable(notification: NSNotification) {
        if let urlString = notification.userInfo!["url"]{
            let url : NSURL = NSURL(string: urlString as! String)!
            let fetcher = Fetcher()
            fetcher.requestJSON(url) { (json, message) in
                if let json = json, dict = json as? [Dictionary<String,AnyObject>] {
                    self.names = dict.map { $0["title"] as! String }
                    self.gridCells = dict.map { ($0["contents"]! as! [[Int]]) }
                    let op = NSBlockOperation {
                        self.tableView.reloadData()
                    }
                    NSOperationQueue.mainQueue().addOperation(op)
                }
            }
        }
    }
    
    func addTableCell(notification: NSNotification){
        let newName: String = notification.userInfo!["name"] as! String
        let newCells: [[Int]] = notification.userInfo!["cells"] as! [[Int]]
        names.append(newName)
        gridCells.append(newCells)
        let itemRow = names.count - 1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 0)
        tableView.insertRowsAtIndexPaths([itemPath], withRowAnimation: .Automatic)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableViewDelegation
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("Default")
            else {
                preconditionFailure("missing Default reuse identifier")
        }
        let row = indexPath.row
        guard let nameLabel = cell.textLabel
            else{
                preconditionFailure("no cell label")
        }
        nameLabel.text = names[row]
        cell.tag = row
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            names.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editingRow = (sender as! UITableViewCell).tag
        guard let editingVC = segue.destinationViewController as? EditorViewController
            else {
                preconditionFailure("fail")
        }
        editingVC.gridCells = self.gridCells[editingRow]
        editingVC.name = names[editingRow]
        editingVC.commit = {
            self.names[editingRow] = $0.0
            self.gridCells[editingRow] = $0.1
            let indexPath = NSIndexPath(forRow: editingRow, inSection: 0)
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    
}