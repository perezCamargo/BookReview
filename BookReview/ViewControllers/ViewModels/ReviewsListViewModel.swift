//
//  ReviewsViewModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

final class ReviewsListViewModel: ListViewModel {
    static var arg: ServicesArguments = .reviewsList
    
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
    
    func getFeed() {
        self.isLoading = true

        PostsEndpoints.getPosts.invoke {[weak self] (error) in
            guard let self = self else { return }
            guard let error = error else { return }
            self.error = error
        } onSuccess: {[weak self] (model, code) in
            guard let self = self else { return }
            guard let posts = model as? [PostModel] else {
                return
            }
            
            self.rows = posts
            self.isLoading = false
        }
    }
    
    deinit {
        rowsBind = (value: .reviews([]), bind: nil)
        loadingBind = (value: false, bind: nil)
        errorBind = (value: .none, bind: nil)
    }
}
