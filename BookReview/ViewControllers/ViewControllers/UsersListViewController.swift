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
        navigationItem.title = Localized.usersTitle
        viewModel.getFeed()
    }
    
    override func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.cellIdentifier)
        super.setupTableView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let ListModel.users(users) = viewModel.rowsBind.value {
            let userReviewsVC: UserReviewsViewController = Controllers.userReviews.instance()
            userReviewsVC.model = users[indexPath.row]
            navigationController?.pushViewController(userReviewsVC, animated: true)
        }
    }
}
