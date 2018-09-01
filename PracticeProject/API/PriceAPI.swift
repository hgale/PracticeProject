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
    
    typealias PriceResult = (BPIPrice) -> ()
    
    static let shared = PriceAPI()
    
    private let defaultSession = URLSession(configuration: .default)
    private var pollPriceDataTask: URLSessionDataTask?
    
    private var loading = false

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
                let price = prices.bpi.usd
                DispatchQueue.main.async {
                    completion(price)
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
}

