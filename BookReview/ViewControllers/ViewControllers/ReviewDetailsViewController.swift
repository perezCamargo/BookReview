//
//  ReviewDetailsViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class ReviewDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! /*{
        didSet {
            self.titleLabel.text = self.model?.title
        }
    }*/
    @IBOutlet weak var bodyTextView: UITextView! /*{
        didSet {
            self.bodyLabel.text = self.model?.body
        }
    }*/
    
    var model: PostModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        navigationItem.title = Localized.reviewsTitle
        titleLabel.text = model?.title
        bodyTextView.text = model?.body
    }
}
