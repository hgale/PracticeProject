//
//  BPIPrice.swift
//  PracticeProject
//
//  Created by Harry Tormey on 9/1/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

struct BPIPrice : Codable {
    let code: String
    let description: String
    let rate: Float
    let symbol: String
    enum CodingKeys : String, CodingKey {
        case code
        case description
        case rate = "rate_float"
        case symbol
    }
}
