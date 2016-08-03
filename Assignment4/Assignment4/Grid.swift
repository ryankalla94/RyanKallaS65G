//
//  Grid.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/17/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

class Grid: GridProtocol{
    var rows: Int = 10 {
        didSet{
            board = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        }
    }
    var cols: Int = 10 {
        didSet{
            board = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        }
    }
    var board: [[CellState]] = [[]]
    
    required init(rows: Int, cols: Int){
        self.rows = rows
        self.cols = cols
        board = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
    }
    
    func neighbors(posn: (x: Int, y: Int)) -> Array<(Int,Int)>{
        var neighborsArray: Array<(Int,Int)> = []
        var currPosn: (Int,Int) = ((posn.x + rows - 1) % rows, (posn.y + cols - 1) % cols)
        for x in 0...8{
            if currPosn != posn{
                neighborsArray.append(currPosn)
            }
            if x == 2 || x == 5{
                currPosn = ((currPosn.0 + rows - 2) % rows, (currPosn.1 + 1) % cols)
            } else {
                currPosn = ((currPosn.0 + 1) % rows, currPosn.1)
            }
        }
        return neighborsArray
    }
    
    
    subscript(row: Int, col: Int) -> CellState? {
        get {
            if row >= 0 && row < rows && col >= 0 && col < cols{
                return board[row][col]
            } else { return nil }
        }
        set(newValue) {
            if newValue == nil {
                return
            } else if row >= 0 && row < rows && col >= 0 && col < cols {
                board[row][col] = newValue!
            } else {
                return
            }
        }
    }
}
