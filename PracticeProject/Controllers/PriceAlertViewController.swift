//
//  PriceAlertViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/28/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class PriceAlertViewController: UIViewController {
    private let reuseIdentifier = "AlertCell"
    
    private var tableView: UITableView!
    private var nullStateView: NullStateView!
    private var priceAlerts = [PriceAlert]()
    // fix this
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
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true;
        view.addSubview(tableView)
    }

    // MARK:- Setup constraints

    func setupConstraints() {
        nullStateView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let margin : CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
        // Get rid of screen width, do the leading, trailing thing instead.
        
        // center screen and set its width/height to be based on screenWidth - margin
        NSLayoutConstraint.activate([
            nullStateView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            nullStateView.widthAnchor.constraint(equalTo: nullStateView.heightAnchor),
            nullStateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nullStateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
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
        tableView.isHidden = (priceAlerts.count == 0)
        tableView.reloadData()
        nullStateView.isHidden = (priceAlerts.count > 0)
    }
}

// MARK: - UITableView
extension PriceAlertViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(priceAlerts[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priceAlerts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath as IndexPath)
        let price = priceAlerts[indexPath.row]
        cell.textLabel!.text = "\(price.targetPrice)"
        return cell
    }
}

