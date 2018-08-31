//
//  PriceAPI.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/30/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation
//import UIKit

enum API {
    static let bpi = "bpi"
    static let usd =  "USD"
    static let code = "code"
    static let description = "description"
    static let rate = "rate_float"
    static let symbol = "symbol"
}

final class PriceAPI {
    private let API_URL = "https://api.coindesk.com/v1/bpi/currentprice.json"
    private let INTERVAL: Double = 5
    typealias JSONDictionary = [String: Any]
    
    typealias PriceResult = (BPIPrice) -> ()
    var currentPrice =  BPIPrice(code: "", desc: "", rate: 0.0, symbol: "")

    static let shared = PriceAPI()
    
    private var pollingTimer: Timer!
    
    private let defaultSession = URLSession(configuration: .default)
    private var pollPriceDataTask: URLSessionDataTask?
    
    private var loading = false
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
        requestPrice(completion: {(price: BPIPrice) -> Void in
            print("Poll currentPrice is: ", price)
        })
    }

    func requestPrice(completion: @escaping PriceResult) {
        pollPriceDataTask?.cancel()
        loading = true
        if var urlComponents = URLComponents(string: API_URL) {
            guard let url = urlComponents.url else { return }
            print("Attempting to make request with the following url")
            print("url : ", url)
            pollPriceDataTask = defaultSession.dataTask(with: url) { data, response, error in
                defer { self.pollPriceDataTask = nil }
                self.loading = false
                if let error = error {
                    let errorMessage = "PollPriceDataTask error: " + error.localizedDescription + "\n"
                    print(errorMessage)
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    self.updatePriceFromResult(data)
                    DispatchQueue.main.async {
                        completion(self.currentPrice)
                    }
                }
            }
            
            pollPriceDataTask?.resume()
        }
    }

    fileprivate func updatePriceFromResult(_ data: Data) {
        var response: JSONDictionary?
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            let errorMessage = "JSONSerialization error: \(parseError.localizedDescription)\n"
            print(errorMessage)
            return
        }

        guard let bpiDict = response![API.bpi] as? Dictionary<String, Any> else {
            let errorMessage = "Dictionary does not contain bpi key\n"
            print(errorMessage)
            return
        }

        guard let usdDict = bpiDict[API.usd] as? Dictionary<String, Any>,
            let code = usdDict[API.code] as? String,
            let description = usdDict[API.description] as? String,
            let rate = usdDict[API.rate] as? NSNumber,
            let symbol = usdDict[API.symbol] as? String else {
            let errorMessage = "Dictionary does not contain an expected key\n"
            print(errorMessage)
            return
        }
        currentPrice = BPIPrice(code: code, desc: description, rate: rate.floatValue, symbol: symbol);
    }
}

