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






//Lecture 6

protocol ExampleProtocol {
    var rows: UInt { get set }
    var cols: UInt { get set }
    func step() -> Array<Array<Bool>>
}

protocol ExampleDelegateProtocol {
    func example(e: Example, didUpdateRows: UInt)
}

class Example : ExampleProtocol {
    var rows = UInt(10) {
        didSet {
            if let delegate = delegate {
                delegate.example(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols = UInt(10)
    var delegate: ExampleDelegateProtocol?
    func step() -> Array<Array<Bool>> {
        return []
    }
}

class ExampleDelegate: ExampleDelegateProtocol {
    func example(e: Example, didUpdateRows: UInt) {
        print("x")
    }
}


var ex = Example()
var exd = ExampleDelegate()

ex.delegate = exd
ex.rows = 10



// subscripts

enum ExampleEnum{
    case A
    case B
    case C
    case D
}

protocol ExampleProtocal2 {
    subscript(row: UInt, col: UInt) -> ExampleEnum? { get set }
}

class Example2: ExampleProtocal2{
    var rows: UInt = 10
    var cols: UInt = 10
    private var cells: [ExampleEnum] = [ExampleEnum](count: 100, repeatedValue: .A)
    subscript(row: UInt, col:UInt) -> ExampleEnum? {
        get {
            if row >= rows || col >= cols { return nil }
            if cells.count < Int(row*col) { return nil }
            return cells[Int(row * col + col)] // if 1-D array of cell states
        }
        set (newValue){
            if newValue == nil { return }
            if row < 0 || row >= rows || col < 0 || col >= cols { return }
            let cellRow = row * cols + col
            cells[Int(cellRow)] = newValue!
        }
    }
}



var e = Example2()

e[7,2]
e[3,3] = .B







