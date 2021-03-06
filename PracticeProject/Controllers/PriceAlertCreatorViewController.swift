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
    
    private let reuseIdentifier = "PriceCell"
    // Use private everywhere until the compiler complains
    private let containerView = UIView()
    private let dismissButton = UIButton()
    private let createButton = UIButton()
    private let collectionView =  UICollectionView(frame: .zero , collectionViewLayout: UICollectionViewFlowLayout())
    private let currentPriceView = UILabel()

    private var viewConstraints = [NSLayoutConstraint]()
    // Maybe move these into some kind of setup function
    public var selectedIndex: Float = 0
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
        containerView.backgroundColor = .white
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
        dismissButton.setTitleColor(UIColor.AppTheme.blue, for: .normal)
        dismissButton.setTitle("X", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        containerView.addSubview(dismissButton)
        
        currentPriceView.text = String(Int(currentPrice))
        currentPriceView.font = UIFont.systemFont(ofSize: 20)
        currentPriceView.textColor = UIColor.AppTheme.blue
        currentPriceView.textAlignment = .center
        containerView.addSubview(currentPriceView)
        
        createButton.backgroundColor = UIColor.AppTheme.blue
        createButton.alpha = 0.5
        createButton.titleLabel?.textColor = .white
        createButton.layer.cornerRadius = 5
        createButton.clipsToBounds = true
        createButton.setTitle("Create Alert", for: .normal)
        createButton.setTitleColor(.gray, for: .disabled)
        createButton.isUserInteractionEnabled = false
        createButton.addTarget(self, action: #selector(self.createPrice), for: .touchUpInside)
        containerView.addSubview(createButton)
    }

    // MARK:- Setup constraints

    func setupConstraints() {
        // Create UI that covers halft the screen
        // Add x button to the top
        // Get rid of screenWidth so you never hard code any values
        let screenWidth = UIScreen.main.bounds.width
    
        containerView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        currentPriceView.translatesAutoresizingMaskIntoConstraints = false
        createButton.translatesAutoresizingMaskIntoConstraints = false

        // Use layoutMargins, 
        NSLayoutConstraint.activate([
            // center screen background and set its width/height to be based on screenWidth - margin
            containerView.widthAnchor.constraint(equalToConstant: (screenWidth - UIEdgeInsets.AppTheme.margins.left)),
            containerView.widthAnchor.constraint(equalTo: containerView.heightAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            // Align dismiss button with top right of screen
            dismissButton.topAnchor.constraint(equalTo:containerView.topAnchor, constant: UIEdgeInsets.AppTheme.margins.top),
            dismissButton.trailingAnchor.constraint(equalTo:containerView.trailingAnchor, constant: -UIEdgeInsets.AppTheme.margins.right),
            // Pint create button to bottom of containerview minus a margin
            createButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant:-UIEdgeInsets.AppTheme.margins.left),
            // Set its start/end position to the views width minus a margin
            createButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:UIEdgeInsets.AppTheme.margins.left),
            createButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-UIEdgeInsets.AppTheme.margins.right),
            // Set createButtons height to 15% of the containerViews height
            createButton.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.15),
            // Stack collectionView on top of create button
            collectionView.bottomAnchor.constraint(equalTo: createButton.topAnchor, constant: -UIEdgeInsets.AppTheme.margins.bottom),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:UIEdgeInsets.AppTheme.margins.left),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-UIEdgeInsets.AppTheme.margins.right),
            collectionView.heightAnchor.constraint(equalTo: containerView.heightAnchor,
                                                   multiplier:0.30),
            // Display current price
            currentPriceView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -UIEdgeInsets.AppTheme.margins.bottom),
            currentPriceView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant:UIEdgeInsets.AppTheme.margins.left),
            currentPriceView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant:-UIEdgeInsets.AppTheme.margins.right),
            currentPriceView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier:0.10),
        ])
    }    
}

extension PriceAlertCreatorViewController:  UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    // MARK:- Utility

    func calculatePrice(price : Float, increment: Int, index: Int) -> Float {
        let cellPrice = Float(price) + Float(index * increment)
        return cellPrice
    }

    // MARK:- CollectionView

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PriceCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                               for: indexPath) as! PriceCollectionViewCell

        let cellPrice = calculatePrice(price: currentPrice, increment: priceIncrement, index: indexPath.row)
        cell.title = "\(cellPrice)"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 90
        return CGSize(width:size, height:size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellPrice = calculatePrice(price: currentPrice, increment: priceIncrement, index: indexPath.row)
        // TODO: Make this nicer with a setter
        selectedIndex = cellPrice
        currentPriceView.text = String(selectedIndex)
        createButton.isUserInteractionEnabled = true
        createButton.alpha = 1
        print("Selected: \(cellPrice)")
    }

    // MARK:- Buttons

    @objc func dismissVC() {
        self.dismiss(animated: true, completion:nil)
    }

    @objc func createPrice() {
        let targetPrice = calculatePrice(price: currentPrice, increment: priceIncrement, index: Int(selectedIndex))
        let above: Bool  = targetPrice > currentPrice
        let price = PriceAlert(on: true, above: above, created: Date(), targetPrice: targetPrice)
        self.delegate?.createPriceAlert(priceAlert: price)
        self.dismiss(animated: true, completion:nil)
    }
}

