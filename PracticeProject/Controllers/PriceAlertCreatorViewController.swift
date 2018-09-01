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
    // Use private everywhere until the compiler complains
    private let containerView = UIView()
    private let dismissButton = UIButton()
    private let createButton = UIButton()
    private let collectionView =  UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
    let currentPriceView = UILabel()

    private var viewConstraints = [NSLayoutConstraint]()
    
    public var selectedPrice = 0
    public var currentPrice: Float = 0
    public var priceIncrement = 5
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        view.isOpaque = false
        addViews()
        setupConstraints()
    }
    // Only use loadView if you are replacing the view itself

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

        dismissButton.backgroundColor = .clear
        dismissButton.titleLabel?.textColor = .white
        dismissButton.setTitle("X", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        containerView.addSubview(dismissButton)
        
        currentPriceView.text = String(Int(currentPrice))
        currentPriceView.font = UIFont.systemFont(ofSize: 20)
        currentPriceView.textColor = .white
        currentPriceView.textAlignment = .center
        containerView.addSubview(currentPriceView)
        
        createButton.backgroundColor = .blue
        createButton.titleLabel?.textColor = .white
        createButton.layer.cornerRadius = 5
        createButton.clipsToBounds = true
        createButton.setTitle("Create Alert", for: .normal)
        createButton.addTarget(self, action: #selector(self.createPrice), for: .touchUpInside)
        containerView.addSubview(createButton)
    }

    // MARK:- Setup constraints

    func setupConstraints() {
        // Create UI that covers halft the screen
        // Add x button to the top
        let margin : CGFloat = 20
        // Get rid of screenWidth so you never hard code any values
        let screenWidth = UIScreen.main.bounds.width
    
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        currentPriceView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        // Use layoutMargins, 
        NSLayoutConstraint.activate([
            // center screen background and set its width/height to be based on screenWidth - margin
            containerView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Align dismiss button with top right of screen
            dismissButton.topAnchor.constraint(equalTo:containerView.topAnchor, constant: margin),
            dismissButton.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -margin),
            // Pint create button to bottom of containerview minus a margin
            createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-margin),
            // Set its start/end position to the views width minus a margin
            createButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            createButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            // Set createButtons height to 15% of the containerViews height
            createButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.15),
            // Stack collectionView on top of create button
            collectionView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -margin),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            collectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor,
                                                   multiplier:0.30),
            // Display current price
            currentPriceView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -margin),
            currentPriceView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:margin),
            currentPriceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-margin),
            currentPriceView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.10),
        ])
    }    
}

