//: Playground - noun: a place where people can play

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

var l = CellState.Living
l.rawValue
l.description()
l.toggle(l)



@IBDesignable class GridView: UIView{
    
    var grid: Array<Array<CellState>> = [[CellState]](count: 20, repeatedValue: [CellState](count: 20, repeatedValue: CellState.Empty))
    
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
    @IBInspectable var gridWidth: CGFloat = 50
    
    
}


var grid = GridView()
grid.grid
grid.cols = 5
grid.grid
grid.rows = 5
grid.grid



























