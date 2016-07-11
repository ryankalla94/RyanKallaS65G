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

class RecView : UIView{
    var rectColor:UIColor = UIColor.lightGrayColor() {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let x = rect.origin.x + rect.size.width/3.0
        let y = rect.origin.y + rect.size.height/3.0
        let w = rect.size.width/3.0
        let h = rect.size.height/3.0
        let centerRect = CGRectMake(x,y,w,h)
        
        let c = UIGraphicsGetCurrentContext()
        
        CGContextAddRect(c, centerRect)
        CGContextSetStrokeColorWithColor(c, UIColor.redColor().CGColor)
        CGContextSetLineWidth(c, 4.0)
        CGContextStrokePath(c)
        CGContextSetFillColorWithColor(c, rectColor.CGColor)
        CGContextFillRect(c, centerRect)
    }
    
    
    
    
}
let rect = CGRectMake(0,0,100,100)

let superView = UIView(frame: CGRectMake(0,0, 600.0, 600.0))

let x = RecView()

// set rows and collumns as IBInspectable variables




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
    
    @IBInspectable var rows: Int = 20{
        didSet{
            print("rows set");
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
        // Draws the collumn lines
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
        // Draws the circles
        
        for i in 0..<rows{
            for j in 0..<cols{
                let newRect = CGRectMake(CGFloat(j)*(rect.width/CGFloat(cols)), CGFloat(i)*(rect.height/CGFloat(rows)), rect.width/CGFloat(cols), rect.height/CGFloat(rows))
                let circle = UIBezierPath(ovalInRect: newRect)
                switch grid[i][j]{
                case CellState.Living: livingColor.setFill();
                case CellState.Born: bornColor.setFill();
                case CellState.Empty: emptyColor.setFill();
                case CellState.Died: diedColor.setFill()
                }
                circle.fill()
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
            }
            self.setNeedsDisplay()
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let point: CGPoint = touch.locationInView(self)
            let index = pointToIndex(point)
            if index.0 >= 0 && index.0 < rows-1 && index.1 >= 0 && index.1 < cols-1{ // makes sure touches are inside the grid
                grid[index.0][index.1] = grid[index.0][index.1].toggle(grid[index.0][index.1])
            }
            self.setNeedsDisplay()
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
        let size = board.count
        var neighborsArray: Array<(Int,Int)> = []
        var currPosn: (Int,Int) = ((posn.x + size - 1) % size, (posn.y + size - 1) % size)
        for x in 0...8{
            if currPosn != posn{
                neighborsArray.append(currPosn)
            }
            if x == 2 || x == 5{
                currPosn = ((currPosn.0 + size - 2) % size, (currPosn.1 + 1) % size)
            } else {
                currPosn = ((currPosn.0 + 1) % size, currPosn.1)
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
        let size = board.count
        var next: Array<Array<CellState>> = [[CellState]](count: self.rows, repeatedValue: [CellState](count: self.cols, repeatedValue: .Empty))
        for x in 0...size-1{
            for y in 0...size-1{
                next[x][y] = nextState(board[x][y], n: countAliveNeighbors2(neighbors((x,y), board: board), board: board))
            }
        }
        return next
    }



}
