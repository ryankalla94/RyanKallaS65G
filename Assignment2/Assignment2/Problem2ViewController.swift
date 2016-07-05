//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Ryan Kalla on 6/30/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

class Problem2ViewController: UIViewController{
    
    @IBOutlet weak var problem2TextView: UITextView!
    
    func initilization() -> Bool{
        if arc4random_uniform(3) == 1{
            return true
        } else{
            return false
        }
    }
    
    func numLivingCells(board: Array<Array<Bool>>) -> Int{
        var count = 0
        for x in board{
            for y in x{
                if y == true{
                    count += 1
                }
            }
        }
        return count
    }
    
    func countAliveNeighbors(posn: (x: Int, y: Int), board: Array<Array<Bool>>) -> Int{
        let size = board.count
        var count = 0
        var currPosn: (Int,Int) = ((posn.x + size - 1) % size, (posn.y + size - 1) % size)
        
        for x in 0...8{
            if board[currPosn.0][currPosn.1] == true && currPosn != posn{
                count += 1
            }
            if x == 2 || x == 5{
                currPosn = ((currPosn.0 + size - 2) % size, (currPosn.1 + 1) % size)
            } else {
                currPosn = ((currPosn.0 + 1) % size, currPosn.1)
            }
        }
        return count
    }
    
    func nextState(currentState: Bool, n :Int) -> Bool{
        switch currentState{
        case false :
            if n == 3 {
                return true
            } else {
                return false
            }
        case true:
            if n < 2 || n > 3{
                return false
            } else {
                return true
            }
        }
    }
    
    func nextBoard(board: Array<Array<Bool>>) -> Array<Array<Bool>>{
        let size = board.count
        var next: Array<Array<Bool>> = [[Bool]](count: 5, repeatedValue: [Bool](count: 5, repeatedValue: false))
        for x in 0...size-1{
            for y in 0...size-1{
                next[x][y] = nextState(board[x][y], n: countAliveNeighbors((x,y), board: board))
            }
        }
        return next
    }
    
    @IBAction func problem2ButtonClicked(sender: AnyObject) {
        let board: Array<Array<Bool>> = [[Bool]](count: 5, repeatedValue: [Bool](count: 5, repeatedValue: false))
        let before: Array<Array<Bool>> = board.map{x in x.map{y in initilization()}}
        let after: Array<Array<Bool>> = nextBoard(before)
        let liveCellsBefore = numLivingCells(before)
        let liveCellsAfter = numLivingCells(after)
        problem2TextView.text = "Number of living cells before = \(liveCellsBefore)\nNumber of living cells after = \(liveCellsAfter)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Problem 2"

        
    }
}

