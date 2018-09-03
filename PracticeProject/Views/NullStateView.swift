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
    private let iconLabel = UILabel()
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
        iconView.backgroundColor = .white
        iconView.layer.cornerRadius = iconSize / 2

        // border
        iconView.layer.borderColor = UIColor.gray.cgColor
        iconView.layer.borderWidth = 1.5

        iconLabel.text = "\u{1F514}"
        iconLabel.font = UIFont.systemFont(ofSize: 26)
        iconView.addSubview(iconLabel)

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
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        subTitleView.translatesAutoresizingMaskIntoConstraints = false
        alertButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Look at UIStackView
        // Read more about this.
        // https://developer.apple.com/documentation/uikit/uistackview
        // Co
        viewConstraints.append(alertButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor))
        
        
        // Pin button to bototm of the view minus a margin
        viewConstraints.append(alertButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:UIEdgeInsets.AppTheme.margins.bottom))
        // Set its start/end position to the views width minus a margin
        viewConstraints.append(alertButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:UIEdgeInsets.AppTheme.margins.left))
        viewConstraints.append(alertButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-UIEdgeInsets.AppTheme.margins.right))
        // Set its height to 15% of the views height
        viewConstraints.append(alertButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        // Stack subtitle on top of the view minus a margin
        viewConstraints.append(subTitleView.bottomAnchor.constraint(equalTo: alertButton.topAnchor, constant: -UIEdgeInsets.AppTheme.margins.bottom))
        // Set width to be the width of the screen minus double the margin
        viewConstraints.append(subTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:(UIEdgeInsets.AppTheme.margins.left * 2)))
        viewConstraints.append(subTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:(-UIEdgeInsets.AppTheme.margins.right * 2)))
        // Set height to be same as the buttons, aka, 15% of the screen
        viewConstraints.append(subTitleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        
        // Stack title on top of the subtitle minus a margin
        viewConstraints.append(titleView.bottomAnchor.constraint(equalTo: subTitleView.topAnchor, constant: -UIEdgeInsets.AppTheme.margins.top))
        // Set width to be the width of the screen minus double the margin
        viewConstraints.append(titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant:(UIEdgeInsets.AppTheme.margins.left * 2)))
        viewConstraints.append(titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:(-UIEdgeInsets.AppTheme.margins.right * 2)))
        // Set height to be same as the buttons, aka, 15% of the screen
        viewConstraints.append(titleView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier:0.15))
        
        // Stack icon on top of the title minus a margin
        viewConstraints.append(iconView.bottomAnchor.constraint(equalTo: titleView.topAnchor, constant: -UIEdgeInsets.AppTheme.margins.bottom))
        viewConstraints.append(iconView.centerXAnchor.constraint(equalTo: self.centerXAnchor))
        viewConstraints.append(iconView.heightAnchor.constraint(equalToConstant:iconSize))
        viewConstraints.append(iconView.widthAnchor.constraint(equalTo: iconView.heightAnchor))
        
        viewConstraints.append(iconLabel.centerXAnchor.constraint(equalTo: iconView.centerXAnchor))
        viewConstraints.append(iconLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor))
        
        NSLayoutConstraint.activate(viewConstraints)
    }

    @objc func displayPriceAlert() {
        delegate?.presentPriceAlertCreator()
    }
}
