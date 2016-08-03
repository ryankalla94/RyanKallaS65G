//
//  EditorViewController.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

import UIKit

class EditorViewController: UIViewController {
    
    var gridCells: [[Int]]?
    var name: String?
    var commit: ((String, [[Int]]) -> Void)?
    
    @IBOutlet weak var grid: GridView!
    
    @IBOutlet weak var editName: UITextField!
    
    @IBAction func save(sender: AnyObject) {
        guard let newText = editName.text, commit = commit
            else{
                return
        }
        let cells: [[Int]] = newGridCells()
        commit((newText, cells))
        
        var points: [(Int,Int)] = []
        for x in cells{
            points.append( (x[0], x[1]) )
        }
        grid.points = points
        
        navigationController!.popViewControllerAnimated(true)
        
    }
    
    func newGridCells() -> [[Int]]{
        var cells: [[Int]] = []
        for x in 0..<grid.rows{
            for y in 0..<grid.cols{
                if grid.grid[x][y] == .Living{
                    cells.append([x,y])
                }
            }
        }
        return cells
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var points: [(Int,Int)] = []
        for x in gridCells!{
            points.append( (x[0], x[1]) )
        }
        grid.points = points
        
        editName.text = name
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}