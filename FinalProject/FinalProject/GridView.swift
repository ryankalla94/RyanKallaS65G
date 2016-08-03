//
//  GridView.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GridView: UIView{
    
    var grid: Array<Array<CellState>> = StandardEngine.sharedInstance.getBoard()
    
    var points: [(Int, Int)]? {
        get {
            var p: [(Int, Int)] = []
            for x in 0..<rows {
                for y in 0..<cols {
                    if grid[x][y] == .Living || grid[x][y] == .Born {
                        p.append((x,y))
                    }
                }
            }
            return p
        }
        set(newValue) {
            var largestIndex = 0
            for x in newValue!{
                if x.0 > largestIndex || x.1 > largestIndex{
                    largestIndex = max(x.0,x.1)
                }
            }
            rows = largestIndex+10
            cols = largestIndex+10
            grid = [[CellState]](count:rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
            for x in newValue! {
                grid[x.0][x.1] = .Living
            }
            StandardEngine.sharedInstance.points = newValue!
            StandardEngine.sharedInstance.fromInstrumentation = true
            StandardEngine.sharedInstance.setBoard(grid)
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var rows: Int = StandardEngine.sharedInstance.rows {
        didSet{
            grid = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
            StandardEngine.sharedInstance.grid = Grid(rows: rows, cols: cols)
            StandardEngine.sharedInstance.rows = rows
        }
    }
    @IBInspectable var cols: Int = StandardEngine.sharedInstance.cols {
        didSet{
            grid = [[CellState]](count: rows, repeatedValue: [CellState](count: cols, repeatedValue: CellState.Empty))
            StandardEngine.sharedInstance.grid = Grid(rows: rows, cols: cols)
            StandardEngine.sharedInstance.cols = cols
            //grid = StandardEngine.sharedInstance.getBoard()
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
    
    
    
}
