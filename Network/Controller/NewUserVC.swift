//
//  NewUserVC.swift
//  Network
//
//  Created by LzCtrl on 5/21/20.
//  Copyright © 2020 LzCtrl. All rights reserved.
//

import UIKit

class NewUserVC: UITableViewController {
    
    let textFieldCellID = "textFieldCellID"
    
    let placeholders = ["Name", "Headline"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
    }
    
    private func setupNavBar() {
        self.title = "New User"
        
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        navigationItem.leftBarButtonItem = cancelButton
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .grouped)
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 55
        tableView.register(TextFieldCell.self, forCellReuseIdentifier: textFieldCellID)
    }
    
    @objc
    func cancelButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    func doneButtonPressed() {
        // Create Item
        self.dismiss(animated: true, completion: nil)
    }
}

extension NewUserVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textFieldCellID) as! TextFieldCell
        
        cell.placeholder = placeholders[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
