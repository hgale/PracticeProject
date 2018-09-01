//
//  PriceAPI.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/30/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

final class PriceAPI {
    private let PRICE_API_URL = "https://api.coindesk.com/v1/bpi/currentprice.json"
    private let INTERVAL: Double = 5
    typealias JSONDictionary = [String: Any]
    
    typealias PriceResult = (BPIPrice) -> ()
    var currentPrice =  BPIPrice(code: "", description: "", rate: 0.0, symbol: "")
    
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

    func requestPrice(completion: @escaping PriceResult)  {
        pollPriceDataTask?.cancel()
        loading = true
        guard let gitUrl = URL(string: PRICE_API_URL ) else { return }
        pollPriceDataTask = defaultSession.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            self.loading = false
            do {
                let decoder = JSONDecoder()
                let prices = try decoder.decode(Prices.self, from: data)
                self.currentPrice = prices.bpi.usd
                DispatchQueue.main.async {
                    completion(self.currentPrice)
                }
                
            } catch let err {
                print("Err", err)
            }
        }
        pollPriceDataTask?.resume()
    }
    
    struct Prices : Codable {
        let bpi: BPI
    }

    struct BPI : Codable {
        let eur: BPIPrice
        let gbp: BPIPrice
        let usd: BPIPrice
        
        enum CodingKeys : String, CodingKey {
            case usd = "USD"
            case eur = "EUR"
            case gbp = "GBP"
        }
    }

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
}

