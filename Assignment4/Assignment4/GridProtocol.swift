//
//  GridProtocol.swift
//  Assignment4
//
//  Created by Ryan Kalla on 7/17/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

protocol GridProtocol {
    var rows: Int { get }
    var cols: Int { get }
    init(rows: Int, cols: Int)
    
    func neighbors(posn: (x: Int, y: Int)) -> [(Int,Int)]
    
    subscript(row: Int, col: Int) -> CellState? { get set }
}