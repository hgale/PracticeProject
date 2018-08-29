//
//  PriceAlertCreatorViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class PriceAlertCreatorViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    var delegate: PriceAlertDelegate?

    private let currentPrice: CGFloat = 0.0
    
    fileprivate let reuseIdentifier = "PriceCell"
    
    fileprivate let containerView = UIView()
    fileprivate let dismissButton = UIButton()
    fileprivate let createButton = UIButton()

    fileprivate let collectionView =  UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        
        view.addSubview(containerView)
        // Create UI that covers halft the screen
        // Add x button to the top
        let margin : CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
        containerView.backgroundColor = .purple
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // center screen and set its width/height to be based on screenWidth - margin
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.backgroundColor = .clear
        dismissButton.titleLabel?.textColor = .white
        dismissButton.setTitle("X", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        containerView.addSubview(dismissButton)

        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo:containerView.topAnchor, constant: margin),
            dismissButton.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -margin),
        ])
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -margin),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            collectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.30),
        ])
        /*
        // Pin button to bototm of the view minus a margin
        viewConstraints.append(alertButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:-margin))
        // Set its start/end position to the views width minus a margin
        viewConstraints.append(alertButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:margin))
        viewConstraints.append(alertButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-margin))
        // Set its height to 15% of the views height
        viewConstraints.append(alertButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        // Stack subtitle on top of the view minus a margin
        viewConstraints.append(subTitleView.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -margin))
        // Set width to be the width of the screen minus double the margin
        viewConstraints.append(subTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:(margin * 2)))
        viewConstraints.append(subTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:(-margin * 2)))
        // Set height to be same as the buttons, aka, 15% of the screen
        viewConstraints.append(subTitleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        */
        // Title New price Alert
        // Current Price
        // Below line price line above
        // Horizontal scrolling price picker
        // Create button.
        
    }

    @objc func dismissVC() {
        self.dismiss(animated: true, completion:nil)
    }
    
    @objc func createPrice() {
        self.dismiss(animated: true, completion:nil)
    }
    
    // MARK:- CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24;
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                               for: indexPath) as! PriceCollectionViewCell

        cell.title = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 80//UIScreen.main.bounds.width * 0.2
        return CGSize(width:size, height:size)
    }
}

