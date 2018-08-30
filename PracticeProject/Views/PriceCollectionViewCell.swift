//
//  PriceCollectionViewCell.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/29/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//

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

class PriceCollectionViewCell: UICollectionViewCell {

    fileprivate let titleView = UILabel()

    fileprivate var viewConstraints = [NSLayoutConstraint]()
    
    var title: String? {
        didSet {
            titleView.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
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
        titleView.font = UIFont.systemFont(ofSize: 16)
        titleView.textColor = .black
        titleView.textAlignment = .center
        contentView.addSubview(titleView)
        
        self.backgroundColor = .green
    }
    
    func setupConstraints() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        viewConstraints.append(titleView.widthAnchor.constraint(equalToConstant:55) )
        viewConstraints.append(titleView.widthAnchor.constraint(equalTo: titleView.heightAnchor))
        viewConstraints.append(titleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor))
        viewConstraints.append(titleView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        NSLayoutConstraint.activate(viewConstraints)
    }
    
}

