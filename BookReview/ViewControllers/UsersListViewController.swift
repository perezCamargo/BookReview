//
//  UsersListViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

final class UsersListViewController: ListViewController<UsersListViewModel> {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localized.usersTitle
    }
    
    override func setupTableView() {
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.cellIdentifier)
        
        super.setupTableView()
    }
    
}
