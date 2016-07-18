//
//  Model.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/16/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation



class StandardEngine: EngineProtocol {
    var delegate: EngineDelegateProtocol?
    var grid : GridProtocol = Grid(rows: 10, cols: 10) {
        didSet{
            if delegate != nil{
                let center = NSNotificationCenter.defaultCenter()
                let n = NSNotification(name: "EngineUpdate", object: nil, userInfo: nil)
                center.postNotification(n)
            }
        }
    }
    var refreshRate: Double = 0
    var refreshTimer = NSTimer()
    var rows: Int = 10 {
        didSet{
            grid = Grid(rows: rows, cols: cols)
        }
    }
    var cols: Int = 10 {
        didSet{
            grid = Grid(rows: rows, cols: cols)
        }
    }
    private static var _sharedInstance = StandardEngine(rows: 10, cols: 10)
    static var sharedInstance:  StandardEngine {
        get{
            return _sharedInstance
        }
    }
    
    required init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    
    func nextState(currentState: CellState, n :Int) -> CellState{
        switch currentState{
        case .Empty, .Died :
            if n == 3 {
                return .Born
            } else {
                return .Empty
            }
        case .Living, .Born:
            if n < 2 || n > 3{
                return .Died
            } else {
                return .Living
            }
        }
    }
    
    func countAliveNeighbors(neighbors: Array<(Int,Int)>, board : Array<Array<CellState>>) -> Int{
        var count = 0
        for posn in neighbors{
            if board[posn.0][posn.1] == .Living || board[posn.0][posn.1] == .Born{
                count += 1
            }
        }
        return count
    }
    
    func step() -> GridProtocol {
        var board = grid.board
        var next: Array<Array<CellState>> = [[CellState]](count: self.rows, repeatedValue: [CellState](count: self.cols, repeatedValue: .Empty))
        for x in 0...rows-1{
            for y in 0...cols-1{
                next[x][y] = nextState(board[x][y], n: countAliveNeighbors(grid.neighbors((x,y)), board: board))
            }
        }
        grid.board = next
        return grid
    }
    
}






