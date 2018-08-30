//
//  BPIPrice.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/30/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//
import Foundation

class BPIPrice : CustomStringConvertible {
    let code: String
    let desc: String
    let rate: Float
    let symbol: String
    
    init(code: String, desc: String, rate: Float, symbol: String) {
        self.code = code
        self.desc = desc
        self.rate = rate
        self.symbol = symbol
    }
    
    var description: String {
        return " description: \(self.desc) code: \(self.code) rate: \(self.symbol) rate: \(String(self.rate)) ."
    }
}
