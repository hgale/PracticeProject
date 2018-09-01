//
//  PollPrice.swift
//  PracticeProject
//
//  Created by Harry Tormey on 9/1/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation
import Foundation

final class PollPrice {
    private let INTERVAL: Double = 5

    var currentPrice =  BPIPrice(code: "", description: "", rate: 0.0, symbol: "")

    static let shared = PollPrice()

    private var pollingTimer: Timer!
    private var isPolling = false

    func startPolling() {
        isPolling = true
        pollingTimer = Timer.scheduledTimer(timeInterval: INTERVAL, target: self, selector: #selector(pollPricesAPI), userInfo: nil, repeats: true)
    }

    func stopPolling() {
        isPolling = false
        pollingTimer.invalidate()
    }

    @objc func pollPricesAPI() {
        PriceAPI.shared.requestPrice(completion: {(price: BPIPrice) -> Void in
            self.currentPrice = price
        })
    }
}
