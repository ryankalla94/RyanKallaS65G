//
//  CellState.swift
//  FinalProject
//
//  Created by Ryan Kalla on 8/1/16.
//  Copyright © 2016 RyanKalla. All rights reserved.
//

import Foundation

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
    func isLiving() -> Bool {
        switch self {
        case .Living, .Born: return true
        case .Died, .Empty: return false
        }
    }
}