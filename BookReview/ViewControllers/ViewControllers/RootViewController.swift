//
//  RootViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

final class RootViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewsVC: ReviewsListViewController = Controllers.reviews.instance()
        let reviewListNavController = UINavigationController(rootViewController: reviewsVC)
        reviewsVC.tabBarItem = UITabBarItem(title: Localized.reviewsTitle,
                                      image: Images.firstTabBarIcon.templateImage,
                                      tag: 0)
        
        let userListVC: UsersListViewController = Controllers.users.instance()
        let userListNavController = UINavigationController(rootViewController: userListVC)
        userListNavController.tabBarItem = UITabBarItem(title: Localized.usersTitle,
                                                    image: Images.secondTabBarIcon.templateImage,
                                                    tag: 1)
        
        viewControllers = [reviewListNavController, userListNavController]
    }
}

