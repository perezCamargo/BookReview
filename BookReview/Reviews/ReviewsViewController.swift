//
//  ReviewsViewController.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import UIKit

class ReviewsViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var detailReviewTxt: UITextView!
    @IBOutlet weak var titleDetail: UILabel!
    
    //MARK:- Variables and Constants
    var idPost: Int = 0
    var reviewDetail : ReviewDetailResponse = ReviewDetailResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //set the title of the navigation bar
        navigationItem.title = "Detail Review"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Call the method
        getTheReviewDetail()
    }
    
    //MARK:- Functions
    func getTheReviewDetail() {
        APIManager.sharedInstance.getDetailReview(id: idPost, onSuccess:  { response in
            
            DispatchQueue.main.async {
                
                //Fill the data when service reponse
                self.reviewDetail = response
                
                //Assign the data to the textView
               self.detailReviewTxt.text = self.reviewDetail.body
               self.titleDetail.text = self.reviewDetail.title
                
                
            }
            
        })
        
    }
    
    


}
