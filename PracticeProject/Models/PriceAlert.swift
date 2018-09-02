//
//  PriceAlert.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/30/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

struct PriceAlert : Codable {
    let on: Bool
    let above: Bool
    let created: Date
    let targetPrice: Float
}
