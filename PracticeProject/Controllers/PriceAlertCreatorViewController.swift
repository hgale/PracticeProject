//
//  PriceAlertCreatorViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class PriceAlertCreatorViewController: UIViewController  {
    var delegate: PriceAlertDelegate?
    
    let reuseIdentifier = "PriceCell"
    
    fileprivate let containerView = UIView()
    fileprivate let dismissButton = UIButton()
    fileprivate let createButton = UIButton()
    fileprivate let collectionView =  UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
    let currentPriceView = UILabel()

    fileprivate var viewConstraints = [NSLayoutConstraint]()
    
    var selectedPrice: Int = 0
    var currentPrice: Int = 0
    var priceIncrement: Int = 5
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
    }
    
    override func loadView() {
        super.loadView()
        addViews()
        setupConstraints()
    }

    // MARK:- Add the subviews

    func addViews() {
        containerView.backgroundColor = .purple
        view.addSubview(containerView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(PriceCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        containerView.addSubview(collectionView)

        containerView.addSubview(dismissButton)
        dismissButton.backgroundColor = .clear
        dismissButton.titleLabel?.textColor = .white
        dismissButton.setTitle("X", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)

        currentPriceView.text = String(currentPrice)
        currentPriceView.font = UIFont.systemFont(ofSize: 20)
        currentPriceView.textColor = .white
        currentPriceView.textAlignment = .center
        containerView.addSubview(currentPriceView)
    }

    // MARK:- Setup constraints

    func setupConstraints() {
        // Create UI that covers halft the screen
        // Add x button to the top
        let margin : CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
    
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        currentPriceView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // center screen background and set its width/height to be based on screenWidth - margin
            containerView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Align dismiss button with top right of screen
            dismissButton.topAnchor.constraint(equalTo:containerView.topAnchor, constant: margin),
            dismissButton.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -margin),
            // Stack collectionView on top of create button
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -margin),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            collectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.30),
            // Display current price
            currentPriceView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -margin),
            currentPriceView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            currentPriceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            currentPriceView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.10),
        ])
    }    
}

