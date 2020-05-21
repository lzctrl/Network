//
//  TitleSubCell.swift
//  Network
//
//  Created by LzCtrl on 5/21/20.
//  Copyright © 2020 LzCtrl. All rights reserved.
//

import UIKit

class TitleSubCell: UITableViewCell {
    
    // -----------------------------------------
    // MARK: Properties
    // -----------------------------------------
    
    var title: String? {
        didSet {
            guard let title = title else { return }
            titleView.text = title
        }
    }
    
    var subTitle: String? {
        didSet {
            guard let sub = subTitle else { return }
            subTitleView.text = sub
        }
    }
    
    // -----------------------------------------
    // MARK: Views
    // -----------------------------------------
    
    lazy var titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    lazy var subTitleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        return label
    }()
    
    // -----------------------------------------
    // MARK: Setup UI
    // -----------------------------------------
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }

    private func setupUI() {
        [titleView, subTitleView].forEach { self.addSubview($0) }
        
        setTitleConstraints()
        setSubTitleConstraints()
    }
    
    private func setTitleConstraints() {
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            titleView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleView.topAnchor.constraint(equalTo: margins.topAnchor),
            titleView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            titleView.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        ])
    }
    
    private func setSubTitleConstraints() {
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            subTitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            subTitleView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subTitleView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            subTitleView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            subTitleView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

