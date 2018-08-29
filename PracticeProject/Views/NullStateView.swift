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
    
    fileprivate let iconView = UIView()
    fileprivate let titleView = UITextView()
    fileprivate let subTitleView = UITextView()
    fileprivate let alertButton = UIButton()
    
    fileprivate var viewConstraints = [NSLayoutConstraint]()
    
    private let title: String
    private let subTitle: String
    private let buttonText: String
    private let action: Selector
    
    init(title: String, subTitle: String, buttonText: String, action: Selector) {
        self.title = title
        self.subTitle = subTitle
        self.buttonText = buttonText
        self.action = action
        
        super.init(frame: CGRect.zero)
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        setup()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        self.setup()
    }
    
    func setup() {
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
        subTitleView.textContainer.maximumNumberOfLines = 2
        subTitleView.font = UIFont.systemFont(ofSize: 16)
        subTitleView.textColor = .gray
        subTitleView.textAlignment = .center
        
        alertButton.backgroundColor = .blue
        alertButton.titleLabel?.textColor = .white
        alertButton.layer.cornerRadius = 5
        alertButton.clipsToBounds = true
        alertButton.setTitle(buttonText, for: .normal)
        alertButton.addTarget(self, action: action, for: .touchUpInside)
        
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
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.activate(viewConstraints)
    }
}
