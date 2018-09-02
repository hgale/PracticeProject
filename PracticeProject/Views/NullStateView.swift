//
//  NullStateView.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

import Foundation

import QuartzCore
import UIKit

class NullStateView: UIView {
    let iconSize: CGFloat = 90
    
    var delegate: PriceAlertDelegate?
    // private used to mean access by things in the same file, swift 3 only accessed by things in
    // the same class.
    // fileprivate access things in this file, including outside of this class.
    // extensions in the same file can access private members, fileprivate means other things
    // beside extensions can use it.
    private let iconView = UIView()
    private let titleView = UILabel()
    private let subTitleView = UILabel()
    private let alertButton = UIButton()
    
    private var viewConstraints = [NSLayoutConstraint]()
    
    private let title: String
    private let subTitle: String
    private let buttonText: String
    
    init(title: String, subTitle: String, buttonText: String) {
        self.title = title
        self.subTitle = subTitle
        self.buttonText = buttonText

        super.init(frame: .zero)
        setup()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    func setup() {
        layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)

        iconView.backgroundColor = .white
        iconView.layer.cornerRadius = iconSize / 2

        // border
        iconView.layer.borderColor = UIColor.gray.cgColor
        iconView.layer.borderWidth = 1.5

        titleView.text = title
        titleView.font = UIFont.systemFont(ofSize: 20)
        titleView.textColor = .black
        titleView.textAlignment = .center

        subTitleView.text = subTitle
        subTitleView.numberOfLines = 2
        subTitleView.font = UIFont.systemFont(ofSize: 16)
        subTitleView.textColor = .gray
        subTitleView.textAlignment = .center
        
        alertButton.backgroundColor = UIColor.AppTheme.blue
        alertButton.titleLabel?.textColor = .white
        alertButton.layer.cornerRadius = 5
        alertButton.clipsToBounds = true
        alertButton.setTitle(buttonText, for: .normal)
        alertButton.addTarget(self, action: #selector(self.displayPriceAlert), for: .touchUpInside)
        
        addSubview(iconView)
        addSubview(titleView)
        addSubview(subTitleView)
        addSubview(alertButton)
        self.backgroundColor = .white
    }

    func setupConstraints() {
        iconView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        alertButton.translatesAutoresizingMaskIntoConstraints = false

        // Look at UIStackView
        // Read more about this.
        // https://developer.apple.com/documentation/uikit/uistackview
        // Co
        viewConstraints.append(alertButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
        
        let margin: CGFloat = 20;
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
        
        // Stack title on top of the subtitle minus a margin
        viewConstraints.append(titleView.bottomAnchor.constraint(equalTo: subTitleView.topAnchor, constant: -margin))
        // Set width to be the width of the screen minus double the margin
        viewConstraints.append(titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:(margin * 2)))
        viewConstraints.append(titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:(-margin * 2)))
        // Set height to be same as the buttons, aka, 15% of the screen
        viewConstraints.append(titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        
        // Stack icon on top of the title minus a margin
        viewConstraints.append(iconView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -margin))
        viewConstraints.append(iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        viewConstraints.append(iconView.heightAnchor.constraint(equalToConstant:iconSize))
        viewConstraints.append(iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor))
        NSLayoutConstraint.activate(viewConstraints)
    }

    @objc func displayPriceAlert() {
        delegate?.presentPriceAlertCreator()
    }
}
