//
//  PostTVCell.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

class PostTVCell: UITableViewCell {
    static let identifier = "PostCell"
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    func setup(_ model: PostModel) {
        titleLabel.text = model.title
        bodyLabel.text = model.body
        accessoryType = .disclosureIndicator
    }

    override func prepareForReuse() {
        titleLabel.text = Localized.empty
        bodyLabel.text = Localized.empty
    }
}
