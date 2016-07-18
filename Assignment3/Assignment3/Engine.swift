//
//  Engine.swift
//  Assignment3
//
//  Created by Ryan Kalla on 7/9/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit

enum CellState: String{
    case Living = "Living"
    case Empty = "Empty"
    case Born = "Born"
    case Died = "Died"
    func description() -> String{
        return self.rawValue
    }
    func allValues() -> Array<CellState>{
        return [Living,Empty,Born,Died]
    }
    func toggle(value:CellState) -> CellState{
        if value == .Living || value == .Born{
            return .Empty
        } else{
            return .Living
        }
    }
}



@IBDesignable class GridView: UIView{
    
    var grid: Array<Array<CellState>> = [[CellState]](count: 20, repeatedValue: [CellState](count: 20, repeatedValue: CellState.Empty))
    
    var rectArray: [[CGRect]] = [[CGRect]](count: 20, repeatedValue: [CGRect](count: 20, repeatedValue: CGRect()))
    
    var currentCellState: CellState = .Empty
    
    var currentRect: CGRect = CGRect()
    
    var initialLoad: Bool = true
    
    var height: CGFloat = 0.0
    var width: CGFloat = 0.0
    
    @IBInspectable var rows: Int = 20{
        didSet{
            grid = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        }
    }
    @IBInspectable var cols: Int = 20{
        didSet{
            grid = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
        }
    }
    @IBInspectable var livingColor: UIColor = UIColor.cyanColor()
    @IBInspectable var bornColor: UIColor = UIColor.yellowColor()
    @IBInspectable var emptyColor: UIColor = UIColor.blackColor()
    @IBInspectable var diedColor: UIColor = UIColor.redColor()
    @IBInspectable var gridColor: UIColor = UIColor.whiteColor()
    @IBInspectable var gridWidth: CGFloat = 50
    
    override func drawRect(rect: CGRect) {
        let outline = UIBezierPath(rect: rect)
        outline.lineWidth = gridWidth
        gridColor.setStroke()
        outline.stroke()
        let path = UIBezierPath()
        path.lineWidth = gridWidth
        
        if initialLoad{
            initialLoad = false
            height = rect.height
            width = rect.width
             //Draws the collumn lines
                    for i in 1...cols{
                        path.moveToPoint(CGPoint(x:CGFloat(i)*(rect.width/CGFloat(cols)), y: 0))
                        path.addLineToPoint(CGPoint(x:CGFloat(i)*(rect.width/CGFloat(cols)), y: rect.height))
                        path.closePath()
                        path.stroke()
            
                   }
                    // Draws the row lines
                    for i in 1...rows{
                        path.moveToPoint(CGPoint(x:0, y: CGFloat(i)*(rect.height/CGFloat(rows))))
                        path.addLineToPoint(CGPoint(x: rect.width, y: CGFloat(i)*(rect.height/CGFloat(rows))))
                        path.closePath()
                        path.stroke()
                    }
             //Draws the circles
            
                    for i in 0..<rows{
                        for j in 0..<cols{
                            let newRect = CGRectMake(CGFloat(j)*(rect.width/CGFloat(cols)), CGFloat(i)*(rect.height/CGFloat(rows)), rect.width/CGFloat(cols), rect.height/CGFloat(rows))
                            let circle = UIBezierPath(ovalInRect: newRect)
                            rectArray[i][j] = newRect
                            switch grid[i][j]{
                            case CellState.Living: livingColor.setFill();
                            case CellState.Born: bornColor.setFill();
                            case CellState.Empty: emptyColor.setFill();
                            case CellState.Died: diedColor.setFill()
                            }
                            circle.fill()
                        }
                    }
            
            
            
        } else {
            
            print(currentRect)
            print(currentCellState)
        
        let circle = UIBezierPath(ovalInRect: currentRect)
        switch currentCellState{
        case CellState.Living: livingColor.setFill();
        case CellState.Born: bornColor.setFill();
        case CellState.Empty: emptyColor.setFill();
        case CellState.Died: diedColor.setFill()
        }
        circle.fill()
        
        }
    }

    
    func willSet(oldGird: [[CellState]], newGrid: [[CellState]]){
        for x in 0 ..< rows{
            for y in 0 ..< cols{
                if oldGird[x][y] != newGrid[x][y]{
                    currentCellState = newGrid[x][y]
                    currentRect = rectArray[x][y]
                    self.setNeedsDisplayInRect(rectArray[x][y])
                    
                }
            }
        }
    }
    
 
    

    
    
    // Finds corresponding index for the circle that was touched
    func pointToIndex(point: CGPoint) -> (Int,Int){
        let x: Int = Int(point.y/(CGFloat(self.frame.height)/CGFloat(rows)))
        let y: Int = Int(point.x/(CGFloat(self.frame.width)/CGFloat(cols)))
        return(x,y)
    }
    
    // Touch methods
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point: CGPoint = touch.locationInView(self)
            let index = pointToIndex(point)
            if index.0 >= 0 && index.0 < rows && index.1 >= 0 && index.1 < cols{ // makes sure touches are inside the grid
                grid[index.0][index.1] = grid[index.0][index.1].toggle(grid[index.0][index.1])
                currentCellState = grid[index.0][index.1]
                currentRect = rectArray[index.0][index.1]
                self.setNeedsDisplayInRect(rectArray[index.0][index.1])
            }
            
            
        }
        super.touchesBegan(touches, withEvent:event)
    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point: CGPoint = touch.locationInView(self)
            let index = pointToIndex(point)
            if index.0 >= 0 && index.0 < rows-1 && index.1 >= 0 && index.1 < cols-1{ // makes sure touches are inside the grid
                grid[index.0][index.1] = grid[index.0][index.1].toggle(grid[index.0][index.1])
                currentCellState = grid[index.0][index.1]
                currentRect = rectArray[index.0][index.1]
                self.setNeedsDisplayInRect(rectArray[index.0][index.1])

            }
            
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
    
    // Step methods
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
    
    
    func neighbors(posn: (x: Int, y: Int), board: Array<Array<CellState>>) -> Array<(Int,Int)>{
        //let size = cols
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
    
    func countAliveNeighbors2(neighbors: Array<(Int,Int)>, board : Array<Array<CellState>>) -> Int{
        var count = 0
        for posn in neighbors{
            if board[posn.0][posn.1] == .Living || board[posn.0][posn.1] == .Born{
                count += 1
            }
        }
        return count
    }
    
    
    func step2(board: Array<Array<CellState>>) -> Array<Array<CellState>>{
        //let size = cols
        var next: Array<Array<CellState>> = [[CellState]](count: self.rows, repeatedValue: [CellState](count: self.cols, repeatedValue: .Empty))
        for x in 0...rows-1{
            for y in 0...cols-1{
                next[x][y] = nextState(board[x][y], n: countAliveNeighbors2(neighbors((x,y), board: board), board: board))
            }
        }
        return next
    }
    



}
