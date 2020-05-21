//
//  TextfieldCell.swift
//  Network
//
//  Created by LzCtrl on 5/21/20.
//  Copyright © 2020 LzCtrl. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    // -----------------------------------------
    // MARK: Properties
    // -----------------------------------------
    
    var placeholder: String? {
        didSet {
            if let placeholder = placeholder {
                nameField.placeholder = placeholder
            }
        }
    }
    
    var name: String? {
        didSet {
            if let name = name {
                nameField.text = name
            }
        }
    }
    
    // -----------------------------------------
    // MARK: Views
    // -----------------------------------------
    
    lazy var nameField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textColor = UIColor.black
        tf.font = UIFont(name: "Helvetica Neue", size: 16.0)
        tf.autocapitalizationType = .words
        tf.borderStyle = .none
        return tf
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
        self.addSubview(nameField)
        
        setNameFieldConstraints()
    }
    
    private func setNameFieldConstraints() {
        let margins = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            nameField.topAnchor.constraint(equalTo: margins.topAnchor),
            nameField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            nameField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            nameField.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            nameField.heightAnchor.constraint(greaterThanOrEqualToConstant: 25.0)
        ])
    }

}

extension TextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

