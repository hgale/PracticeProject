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
        priceAlertVC.currentPrice = 7045
        priceAlertVC.modalPresentationStyle = .overCurrentContext
        priceAlertVC.delegate = self
        self.present(priceAlertVC, animated: false, completion: nil)
    }

    func createPriceAlert(price: Int) {
        print("createPriceAlert with ", price)
    }
}
