//
//  EngineProtocol.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/17/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

protocol EngineProtocol {
    var delegate: EngineDelegateProtocol? { get set }
    var grid: GridProtocol { get }
    var refreshRate: Double { get set }
    var refreshTimer: NSTimer { get set }
    var rows: Int { get set }
    var cols: Int { get set }
    
    init(rows: Int, cols: Int)
    
    func step() -> GridProtocol
}