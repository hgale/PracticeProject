//
//  PriceAlertViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/28/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class PriceAlertViewController: UIViewController {

    private var nullStateView: NullStateView!
    private var priceAlerts = [PriceAlert]()
    //
    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(displayPriceAlert))
        barButtonItem.tintColor = .white
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.AppTheme.background
        self.title = "Alerts"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func loadView() {
        super.loadView()
        addViews()
        setupConstraints()
    }

    // MARK:- Add the subviews

    func addViews() {
        nullStateView = NullStateView(
            title: "Never miss an opportunity",
            subTitle: "We'll send you notifications when prices go above or below your targets",
            buttonText: "Create Price Alert")
        nullStateView.delegate = self
        view.addSubview(nullStateView)
    }

    // MARK:- Setup constraints

    func setupConstraints() {
        nullStateView.translatesAutoresizingMaskIntoConstraints = false

        let margin : CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
        // Get rid of screen width, do the leading, trailing thing instead.
        
        // center screen and set its width/height to be based on screenWidth - margin
        NSLayoutConstraint.activate([
            nullStateView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            nullStateView.widthAnchor.constraint(equalTo: nullStateView.heightAnchor),
            nullStateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nullStateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

// Extension is like a category. Used to break up class
// to give it more, conformance to protocols inside the same file.
// Make the files a bit smaller.
extension PriceAlertViewController: PriceAlertDelegate {

    @objc func displayPriceAlert(sender: UIBarButtonItem) {
        self.presentPriceAlertCreator()
    }

    func presentPriceAlertCreator() {
        let priceAlertVC = PriceAlertCreatorViewController()
        let price = PollPrice.shared.currentPrice
        priceAlertVC.currentPrice = price.rate
        priceAlertVC.priceIncrement = 10
        priceAlertVC.modalPresentationStyle = .overCurrentContext
        priceAlertVC.delegate = self
        self.present(priceAlertVC, animated: true, completion: nil)
    }
    
    func createPriceAlert(priceAlert: PriceAlert) {
        print("createPriceAlert hit with ", priceAlert)
        priceAlerts.append(priceAlert)
    }
}

