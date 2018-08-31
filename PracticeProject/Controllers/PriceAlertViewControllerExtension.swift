//
//  PriceAlertViewControllerExtension.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

extension PriceAlertViewController: PriceAlertDelegate {
    
    func presentPriceAlertCreator() {
        let priceAlertVC = PriceAlertCreatorViewController()
        let price = PriceAPI.shared.currentPrice;
        priceAlertVC.currentPrice = price.rate
        priceAlertVC.priceIncrement = 10
        priceAlertVC.modalPresentationStyle = .overCurrentContext
        priceAlertVC.delegate = self
        self.present(priceAlertVC, animated: true, completion: nil)
    }

    func createPriceAlert(price: Int) {
        print("createPriceAlert with ", price)
    }
}
