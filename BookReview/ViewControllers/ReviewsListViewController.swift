//
//  ReviewsListViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

final class ReviewsListViewController: ListViewController<ReviewsListViewModel> {
    override var rowHeigth: CGFloat {
        get {
            return 150.0
        }
        set {
            super.rowHeigth = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Localized.reviewsTitle
    }
    
    override func setupTableView() {
        tableView.register(UINib(nibName: "PostTVCell", bundle: nil), forCellReuseIdentifier: PostTVCell.identifier)
        super.setupTableView()
    }
}
