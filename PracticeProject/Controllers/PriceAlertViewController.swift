//
//  PriceAlertViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/28/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit

class PriceAlertViewController: UIViewController {

    fileprivate var nullStateView: NullStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        addViews()
        setupConstraints()
    }

    // MARK:- Add the subviews

    func addViews() {
        nullStateView = NullStateView(title: "Never miss an opportunity",
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

        // center screen and set its width/height to be based on screenWidth - margin
        NSLayoutConstraint.activate([
            nullStateView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            nullStateView.widthAnchor.constraint(equalTo: nullStateView.heightAnchor),
            nullStateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nullStateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

