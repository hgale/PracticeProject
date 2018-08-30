//
//  PriceAlertCreatorViewControllerExtension.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

extension PriceAlertCreatorViewController:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    // MARK:- Utility

    func calculatePrice(price : Int, inrement: Int, index: Int) -> Int {
        let cellPrice = price + (index * inrement)
        return cellPrice
    }

    // MARK:- CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                               for: indexPath) as! PriceCollectionViewCell
        
        let cellPrice = calculatePrice(price: currentPrice, inrement: priceIncrement, index: indexPath.row)
        cell.title = "\(cellPrice)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 90
        return CGSize(width:size, height:size)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellPrice = calculatePrice(price: currentPrice, inrement: priceIncrement, index: indexPath.row)
        // TODO: Make this nicer with a setter
        selectedPrice = cellPrice
        currentPriceView.text = String(selectedPrice)
        print("Selected: \(cellPrice)")
    }

    // MARK:- Buttons

    @objc func dismissVC() {
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func createPrice() {
        self.dismiss(animated: true, completion:nil)
    }

}
