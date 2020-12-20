//
//  UsersListViewModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

class UsersListViewModel: ListViewModel {
    static var arg: ServicesArguments = .usersList
    
    var rowsBind: Bind<[UserModel]> = (value: [], bind: nil)
    var loadingBind: Bind<Bool> = (value: false, bind: nil)
    var errorBind: Bind<NetworkError> = (value: .none, bind: nil)
    
    private var rows: [UserModel] = [] {
        didSet {
            self.rowsBind.value = self.rows
            self.rowsBind.bind?(self.rows)
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
        
        UserEndpoints.getUsers.invoke { (error) in
            print("::: Error VM")
        } onSuccess: {[weak self] (model, code) in
            guard let self = self else { return }
            guard let users = model as? [UserModel] else {
                return
            }
            
            self.rows = users
            self.isLoading = false
        }
    }
    
    deinit {
        rowsBind = (value: [], bind: nil)
        loadingBind = (value: false, bind: nil)
        errorBind = (value: .none, bind: nil)
    }
}
