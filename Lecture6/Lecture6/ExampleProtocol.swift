//
//  ExampleProtocol.swift
//  Lecture6
//
//  Created by Ryan Kalla on 7/11/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation


protocol ExampleProtocol {
    var rows: UInt { get set }
    var cols: UInt { get set }
    var delegate: ExampleDelegateProtocol? { get set }
    func step() -> Array<Array<Bool>>
    
    var refreshInterval: NSTimeInterval { get set }
}

protocol ExampleDelegateProtocol {
    func example(e: Example, didUpdateRows: UInt)
}

class Example : ExampleProtocol {
    
    // static var - used to access instance anywhere (like a global variable)
    private static var _sharedInstance = Example()
    static var sharedInstance:  Example {
        get{
            return _sharedInstance
        }
    }
    
    var rows = UInt(0) {
        didSet {
            if let delegate = delegate {
                delegate.example(self, didUpdateRows: self.rows)
            }
        }
    }
    var cols = UInt(0)
    var delegate: ExampleDelegateProtocol?
    func step() -> Array<Array<Bool>> {
        return []
    }
    
    
    // timer
    
    private var timer: NSTimer?
    
    var refreshInterval: NSTimeInterval = 0 {
        didSet{
            if refreshInterval != 0 {
                if let timer = timer { timer.invalidate() }
                let sel = #selector(Example.timerDidFire(_:))
                timer = NSTimer.scheduledTimerWithTimeInterval(refreshInterval,
                                                               target: self,
                                                               selector: sel,
                                                               userInfo: nil,
                                                               repeats: true )
            }
            else if let timer = timer{
                timer.invalidate()
                self.timer = nil
            }
        }
    }
    
    @objc func timerDidFire(timer: NSTimer){
        self.rows += 1
        // step(board)
        
        let center = NSNotificationCenter.defaultCenter()
        let n = NSNotification(name: "ExampleNotification", object: nil, userInfo: nil)
        center.postNotification(n)
    }
    
    
    
}

class ExampleDelegate: ExampleDelegateProtocol {
    func example(e: Example, didUpdateRows: UInt) {
        print("x")
    }
}


// can be used as a global variable (referenced anywhere in the program)
var Example2 = Example()











