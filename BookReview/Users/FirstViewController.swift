//
//  FirstViewController.swift
//  BookReview
//
//  Created by Angel Casado on 2/1/16.
//  Copyright © 2016 Televisa. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK:- Constant and variables
    var reviews: [ReviewsData] = [ReviewsData]()
     private let identifier = "ReviewsTableViewCell"
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     //Call the method
        self.getTheReviews()
    }

    //MARK:- TableView Protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath as IndexPath) as! ReviewsTableViewCell
      
        cell.bodyReview.text = reviews[indexPath.row].title + "\n" + "\n" + reviews[indexPath.row].body
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
         let vc = storyboard?.instantiateViewController(withIdentifier: "ReviewsViewController") as? ReviewsViewController
        
        vc?.idPost = reviews[indexPath.row].id
         self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK:- Functions
    func getTheReviews() {
        APIManager.sharedInstance.getTheReviews(onSuccess:  { response in
            
            DispatchQueue.main.async {
                
                //Reload the data when the service respond.
                self.reviews = response.data
                self.tableView.reloadData()
                self.tableView.updateConstraintsIfNeeded()
                self.tableView.autoresizesSubviews = true
            }
            
        })
        
        
    }
    

    
}

