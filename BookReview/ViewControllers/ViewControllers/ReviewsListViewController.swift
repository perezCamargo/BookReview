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
        set { }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Localized.reviewsTitle
        viewModel.getFeed()
    }
    
    override func setupTableView() {
        tableView.register(UINib(nibName: "PostTVCell", bundle: nil), forCellReuseIdentifier: PostTVCell.identifier)
        super.setupTableView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let ListModel.reviews(posts) = viewModel.rowsBind.value {
            let reviewDetailVC: ReviewDetailsViewController = Controllers.reviewDetails.instance()
            reviewDetailVC.model = posts[indexPath.row]
            navigationController?.pushViewController(reviewDetailVC, animated: true)
        }
    }
}
