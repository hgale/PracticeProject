//
//  PriceAlertViewController.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/28/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import UIKit
import QuartzCore

class PriceAlertViewController: UIViewController {

//    private weak var containerView: UIView!
    fileprivate var nullStateView: NullStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
//        self.containerView.backgroundColor = .white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    override func loadView() {
        super.loadView()

        // Create the Null state view.
        // Image
        
        // Title
        // Subtitle
        // Button
        
        let margin : CGFloat = 20
        let screenWidth = UIScreen.main.bounds.width
        nullStateView = NullStateView(title: "Never miss an opportunity",
                                      subTitle: "We'll send you notifications when prices go above or below your targets",
                                      buttonText: "Create Price Alert",
                                      action: #selector(self.displayPriceAlert))
        nullStateView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nullStateView);
        // center screen and set its width/height to be based on screenWidth - margin
        NSLayoutConstraint.activate([
            nullStateView.widthAnchor.constraint(equalToConstant: (screenWidth - margin)),
            nullStateView.widthAnchor.constraint(equalTo: nullStateView.heightAnchor),
            nullStateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            nullStateView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])

    }
    
    @objc func displayPriceAlert() {
        print("Button Clicked")
    }

}

