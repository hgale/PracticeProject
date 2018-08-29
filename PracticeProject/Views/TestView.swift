//
//  TestView.swift
//  PracticeProject
//
//  Created by Harry Tormey on 8/28/18.
//  Copyright © 2018 Harry Tormey. All rights reserved.
//
import UIKit


class TestView: UIView {
    private let title: String
    private let subTitle: String
    private let action: Selector

    init(title: String, subTitle: String, action: Selector) {
        self.title = title
        self.subTitle = subTitle
        self.action = action
        
        super.init(frame: CGRect.zero)
        
        setup()
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
        // TODO refactor this so the views only get configured not added every time
        let margin : CGFloat = 20
        self.backgroundColor = UIColor.green
        print("Title is ", self.title)
        let title: UITextView = UITextView(frame: .zero)
        title.text = self.title
        title.font = UIFont.systemFont(ofSize: 20)
        title.textColor = .black
        title.textAlignment = .center
        title.sizeToFit()
        title.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(title)
        
        NSLayoutConstraint.activate([
            title.widthAnchor.constraint(equalToConstant: title.bounds.width),
            title.heightAnchor.constraint(equalToConstant: title.bounds.height),
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.topAnchor.constraint(equalTo: self.topAnchor),
            ])
        
        let subTitle: UITextView = UITextView(frame: CGRect(x: 0, y: 0, width: 300, height: 50))
        subTitle.text = self.subTitle
        subTitle.textContainer.maximumNumberOfLines = 2
        subTitle.font = UIFont.systemFont(ofSize: 16)
        subTitle.textColor = .gray
        subTitle.textAlignment = .center
        
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subTitle)
        
        NSLayoutConstraint.activate([
            subTitle.widthAnchor.constraint(equalToConstant: subTitle.bounds.width),
            subTitle.heightAnchor.constraint(equalToConstant: (subTitle.bounds.height + margin) ),
            subTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            ])
        
        let button:UIButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.backgroundColor = .blue
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.setTitle("Create Price Alert", for: .normal)
        //        button.addTarget(self, action: self.action, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: (200 - margin * 2)),
            button.heightAnchor.constraint(equalToConstant: 50 ),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
    }
}
