//
//  ListViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    private static let cellIdentifier = "basicCell"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: ListViewController.cellIdentifier)
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    
    private lazy var loadingView: LoadingView = ServiceLocator.getService()
    private var viewModel: UsersViewModel = UsersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getFeed()
        self.navigationItem.title = Localized.usersTitle
    }
    
    private func bind() {
        viewModel.rowsBind.bind = { [weak self] rows in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.loadingBind.bind = { [weak self] isLoading in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if isLoading {
                    self.loadingView.run(self.view)
                } else {
                    self.loadingView.stop()
                }
                
            }
        }
        
        viewModel.errorBind.bind = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                print("::: will present error screen/alert with retry button")
            }
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("::: Tapped: \(indexPath)")
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsBind.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard var cell = tableView.dequeueReusableCell(withIdentifier: ListViewController.cellIdentifier) else {
            fatalError("could not dequeue basic cell")
        }
        let model = viewModel.rowsBind.value[indexPath.row]
        
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: ListViewController.cellIdentifier)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text =  model.name
        cell.detailTextLabel?.text = model.email
        return cell
    }
}

class UsersViewModel {
    typealias Bind<T> = (value: T, bind: ((T) -> Void)?)
    
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
