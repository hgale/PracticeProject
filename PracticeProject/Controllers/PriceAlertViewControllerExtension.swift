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
        let vc = PriceAlertCreatorViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }

    func createPriceAlert(price: Int) {
        print("createPriceAlert with ", price)
    }
}
