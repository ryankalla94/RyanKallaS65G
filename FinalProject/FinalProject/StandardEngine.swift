//
//  StandardEngine.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation


class StandardEngine: EngineProtocol {
    var delegate: EngineDelegateProtocol?
    var previousBoard: [[CellState]] = [[CellState]](count: 10, repeatedValue: [CellState](count: 10, repeatedValue: .Empty))
    var fromInstrumentation = true
    var setRows = true
    var setCols = true
    var autoRefresh = false
    var grid : GridProtocol = Grid(rows: 10, cols: 10) {
        didSet{
            if StandardEngine.sharedInstance.fromInstrumentation{
                for x in points {
                    grid[x.0,x.1] = .Living
                }
            }
        }
    }
    var points: [(Int,Int)] = []
    var refreshRate: Double = 0 {
        didSet{
            if refreshRate != 0 {
                if let refreshTimer = refreshTimer { refreshTimer.invalidate() }
                let sel = #selector(StandardEngine.sharedInstance.timerDidFire(_:))
                refreshTimer = NSTimer.scheduledTimerWithTimeInterval(refreshRate,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: nil,
                                                               repeats: true )
            }
            else if let refreshTimer = refreshTimer{
                refreshTimer.invalidate()
                self.refreshTimer = nil
            }
        }
    }
    var refreshTimer: NSTimer?
    
    @objc func timerDidFire(timer: NSTimer){
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "TimerUpdate", object: nil, userInfo: nil)
        center.postNotification(n)
    }
    
    var rows: Int = 10 {
        didSet{
            previousBoard = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: .Empty))
            grid = Grid(rows: rows, cols: cols)
            if setRows{
                setRows = false
                let center = NSNotificationCenter.defaultCenter()
                let n = NSNotification(name: "SizeUpdate", object: nil, userInfo: ["rows": rows, "cols": cols])
                center.postNotification(n)
            }
        }
    }
    var cols: Int = 10 {
        didSet{
            previousBoard = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: .Empty))
            grid = Grid(rows: rows, cols: cols)
            if setCols{
                setCols = false
                let center = NSNotificationCenter.defaultCenter()
                let n = NSNotification(name: "SizeUpdate", object: nil, userInfo: ["rows": rows, "cols": cols])
                center.postNotification(n)
            }
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
    
    func getBoard() -> [[CellState]]{
        var board = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        for x in 0 ..< rows{
            for y in 0 ..< cols{
                if let cell = StandardEngine.sharedInstance.grid[x,y] {
                    board[x][y] = cell
                }
            }
        }
        return board
    }
    
    func setBoard(b: [[CellState]]){
        for x in 0..<rows{
            for y in 0 ..< cols{
                StandardEngine.sharedInstance.grid[x,y] = b[x][y]
            }
        }
        if delegate != nil{
            let center = NSNotificationCenter.defaultCenter()
            let n = NSNotification(name: "EngineUpdate", object: nil, userInfo: nil)
            center.postNotification(n)
            delegate?.engineDidUpdate(grid)
        }
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "StatUpdate", object: nil, userInfo: nil)
        center.postNotification(n)
        StandardEngine.sharedInstance.fromInstrumentation = false
    }
    
    func setBoardWithoutNotification(b: [[CellState]]){
        for x in 0..<rows{
            for y in 0 ..< cols{
                StandardEngine.sharedInstance.grid[x,y] = b[x][y]
            }
        }
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "StatUpdate", object: nil, userInfo: nil)
        center.postNotification(n)
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
    
//    func bothAlive(cell1: CellState, cell2: CellState) -> Bool{
//        if cell1 == .Living || cell1 == .Born{
//            
//        }
//    }
    
    func step() -> GridProtocol {
        var board = getBoard()
        var next: Array<Array<CellState>> = [[CellState]](count: self.rows, repeatedValue: [CellState](count: self.cols, repeatedValue: .Empty))
        var sameBoard = true
        var allNeighborhs : [[(Int,Int)]] = []
        for x in 0...rows-1{
            for y in 0...cols-1{
                next[x][y] = nextState(board[x][y], n: countAliveNeighbors(grid.neighbors((x,y)), board: board))
                if board[x][y] == .Living || board[x][y] == .Born{
                    allNeighborhs.append(grid.neighbors((x,y)))
                }
                if next[x][y] != board[x][y] && next[x][y] != previousBoard[x][y]{
                    sameBoard = false
                }
                previousBoard[x][y] = board[x][y]
            }
        }
        // Bonus proposal - change grid when you reach stability
        if sameBoard{
            if allNeighborhs.count == 0 {
                for x in 0...rows-1{
                    for y in 0...cols-1{
                        if arc4random_uniform(5) == 1{
                            next[x][y] = .Born
                        }
                    }
                }
            } else{
                for x in allNeighborhs{
                    for y in x{
                        if arc4random_uniform(2) == 1 {
                            next[y.0][y.1] = .Born
                        }
                    }
                }
            }
        }
        setBoardWithoutNotification(next)
        return grid
    }
    
    
    
}