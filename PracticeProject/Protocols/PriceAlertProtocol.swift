//
//  PriceAlertProtocol.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

protocol PriceAlertDelegate {
    func presentPriceAlertCreator()
    func createPriceAlert(priceAlert: PriceAlert)
}
