//
//  UserReviewDetailViewController.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 2/1/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

class UserReviewDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Variables and constants
    var reviewsForUser: [ReviewsData] = [ReviewsData]()
    private let identifier = "UserReviewDetailTableViewCell"
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set delegate and dataSource
        tableView.delegate = self
        tableView.dataSource = self
        
        //Set the navigation title.
        navigationItem.title = "Users Posts" 
        
     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Call the function
        getTheReviewsForUser()
    }
    
    //MARK:- TablViewProtocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsForUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! UserReviewDetailTableViewCell
        
         cell.reviewDetail.text = reviewsForUser[indexPath.row].title + "\n" + "\n" + reviewsForUser[indexPath.row].body
        
        return cell
        
    }
    
    //Set the size of the cell depending the content size 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- Functions
    func getTheReviewsForUser() {
        APIManager.sharedInstance.getTheReviewsForUser(id: id, onSuccess:  { response in
            
            DispatchQueue.main.async {
                
                //Fill the data when service reponse
                //Reload the data when the service respond.
                self.reviewsForUser = response.data
                self.tableView.reloadData()
                
                //Update the constrains after the data is received depending the size content.
                self.tableView.updateConstraintsIfNeeded()
                
                //Resize the subViews. 
                self.tableView.autoresizesSubviews = true

            }
            
        })

        
        
    }


}
