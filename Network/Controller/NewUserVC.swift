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
    
    var selectedRow: Int?
    
    var name: String = ""
    var headline: String = ""
    
    var isEditingUser: Bool = false
    
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
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? TextFieldCell, let nameField = cell.titleField.text {
            name = nameField
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? TextFieldCell, let headlineField = cell.titleField.text {
            headline = headlineField
        }
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let newItem = UserList(context: context)
        
        if isEditingUser {
            // TODO: Update the editing user
        } else {
            newItem.name = name
            newItem.headline = headline
            
            users.append(newItem)
        }
        
        CoreDataManager.shared.saveContext()
        
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
        let row = indexPath.row
        cell.placeholder = placeholders[indexPath.row]
        
        if isEditingUser {
            if row == 0 {
                cell.title = name
            } else {
                cell.title = headline
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}
