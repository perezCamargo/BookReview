//
//  UserReviewsViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

final class UserReviewsViewController: ListViewController<UserReviewsViewModel> {
    override var rowHeigth: CGFloat {
        get {
            return 150.0
        }
        set { }
    }
    
    var model: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        if let model = self.model {
            navigationItem.title = Localized.userReviewsTitle + model.username
            viewModel.getFeed(args: model.id)
        } else {
            navigationItem.title = Localized.reviewsTitle
            // this will produce an error and the UX error handler will be triggered
            viewModel.getFeed(args: [])
        }
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
    
    override func retryAction() {
        viewModel.getFeed(args: model?.id)
    }
}
