//
//  SecondViewController.swift
//  BookReview
//
//  Created by Angel Casado on 2/1/16.
//  Copyright © 2016 Televisa. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    var userData : [UsersData] = [UsersData]()
    private let identifier = "UserNameTableViewCell"
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Call the function
        getTheUsers()
        
    }
    
    //MARK:- TableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! UserNameTableViewCell
        cell.userName.text = userData[indexPath.row].name
        
        return cell
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "UserReviewDetailViewController") as? UserReviewDetailViewController
        
          vc?.id = userData[indexPath.row].id
        
         self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    //Set the row height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 79.0
    }
    //MARK:- Functions
    func getTheUsers() {
        APIManager.sharedInstance.getTheUsers(onSuccess:  { response in
            
            DispatchQueue.main.async {
                
                
                self.userData = response.data
                self.tableView.reloadData()
            }
            
        })
        
        
    }


}

