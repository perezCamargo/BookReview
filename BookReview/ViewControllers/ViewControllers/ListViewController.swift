//
//  ListViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class ListViewController<ViewModel: ListViewModel>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.setupTableView()
        }
    }
    
    var rowHeigth: CGFloat = 75.0
    
    lazy var viewModel: ListViewModel = ServiceLocator.getService(ViewModel.arg)
    private lazy var loadingView: LoadingView = ServiceLocator.getService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.getFeed()
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
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

// MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("::: Tapped: \(indexPath)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeigth
    }

// MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowModel = viewModel.rowsBind.value
        
        switch rowModel {
        case .users(let users):
            return users.count
        case .reviews(let reviews):
            return reviews.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowModel = viewModel.rowsBind.value
        
        switch rowModel {
        case .users(let users):
            guard var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cellIdentifier) else {
                fatalError("could not dequeue basic cell")
            }
            let model = users[indexPath.row]
            
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: CellIdentifiers.cellIdentifier)
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text =  model.name
            cell.detailTextLabel?.text = model.email
            return cell
            
        case .reviews(let reivews):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTVCell.identifier, for: indexPath) as? PostTVCell else {
                fatalError("could dequeue cell with identifier: \(PostTVCell.identifier)")
            }
            
            let model = reivews[indexPath.row]
            cell.setup(model)
            
            return cell
        }
    }
}
