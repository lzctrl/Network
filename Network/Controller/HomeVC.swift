//
//  ViewController.swift
//  Network
//
//  Created by LzCtrl on 5/20/20.
//  Copyright © 2020 LzCtrl. All rights reserved.
//

import UIKit

var users = [UserList]()

class HomeVC: UITableViewController {
    
    let titleSubCellID = "titleSubCellID"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupTableView()
        loadData()
    }
    
    private func setupNavBar() {
        self.title = "Home"
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUserButtonPressed))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: tableView.frame, style: .grouped)
        tableView.backgroundColor = .white
        tableView.sectionHeaderHeight = 10
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.register(TitleSubCell.self, forCellReuseIdentifier: titleSubCellID)
    }
    
    private func loadData() {
        let shared = CoreDataManager.shared
        users = shared.findAllForEntity("UserList") as! [UserList]
    }
    
    @objc
    func addUserButtonPressed() {
        let nav = UINavigationController(rootViewController: NewUserVC())
        nav.modalPresentationStyle = .fullScreen
        nav.modalTransitionStyle = .coverVertical
        self.present(nav, animated: true, completion: nil)
    }
}

extension HomeVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: titleSubCellID) as! TitleSubCell
        
        cell.title = users[indexPath.row].name
        cell.subTitle = users[indexPath.row].headline
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let row = indexPath.row
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completion) in
            let vc = NewUserVC()
            
            vc.selectedRow = row
            vc.isEditingUser = true
            
            vc.name = users[row].name ?? ""
            vc.headline = users[row].headline ?? ""
            
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            nav.modalTransitionStyle = .coverVertical
            
            self.present(nav, animated: true, completion: nil)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let deletingUser = users[row]
            
            users.remove(at: row)
            context.delete(deletingUser)
            
            CoreDataManager.shared.saveContext()
        
            tableView.deleteRows(at: [indexPath], with: .left)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
