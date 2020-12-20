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
}

final class UserReviewsViewModel: ListViewModel {
    static var arg: ServicesArguments = .userReviewsList
    
    var rowsBind: Bind<ListModel> = (value: .reviews([]), bind: nil)
    var loadingBind: Bind<Bool> = (value: false, bind: nil)
    var errorBind: Bind<NetworkError> = (value: .none, bind: nil)
    
    private var rows: [PostModel] = [] {
        didSet {
            self.rowsBind.value = .reviews(self.rows)
            self.rowsBind.bind?(.reviews(self.rows))
        }
    }
    private var isLoading: Bool = false {
        didSet {
            self.loadingBind.value = self.isLoading
            self.loadingBind.bind?(self.isLoading)
        }
    }
    private var error: NetworkError = .none {
        didSet {
            self.errorBind.value = self.error
            self.errorBind.bind?(self.error)
        }
    }
    
    func getFeed<T>(args: T) {
        self.isLoading = true
        
        guard let id = args as? Int else {
            self.triggerError()
            return
        }
        
        PostsEndpoints.getUserPosts(userId: id).invoke(onFailure: { [weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.error = error
        }, onSuccess: {[weak self] (model, code) in
            guard let self = self else { return }
            guard let posts = model as? [PostModel] else {
                self.triggerError()
                return
            }
            
            self.rows = posts
            self.isLoading = false
        })
    }

    private func triggerError() {
        self.isLoading = false
        self.error = .genericError
    }
    deinit {
        rowsBind = (value: .reviews([]), bind: nil)
        loadingBind = (value: false, bind: nil)
        errorBind = (value: .none, bind: nil)
    }
}
