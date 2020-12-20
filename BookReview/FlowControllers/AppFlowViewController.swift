//
//  AppFlowViewController.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 19/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

protocol AppFlowController where Self: UIViewController {
    func start()
}

class AppFlowViewController: UIViewController, AppFlowController {

    func start() {
        add(child: RootViewController(), container: view)
    }
}

class RootViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reviewsVC = UIViewController()
        let reviewListNavController = UINavigationController(rootViewController: reviewsVC)
        reviewsVC.tabBarItem = UITabBarItem(title: Localized.reviewsTitle,
                                      image: Images.firstTabBarIcon.templateImage,
                                      tag: 0)
        reviewsVC.view.backgroundColor = .blue
        
        let userListVC: UsersListViewController = Controllers.users.instance()
        let userListNavController = UINavigationController(rootViewController: userListVC)
        userListNavController.tabBarItem = UITabBarItem(title: Localized.usersTitle,
                                                    image: Images.secondTabBarIcon.templateImage,
                                                    tag: 1)
        
        viewControllers = [reviewListNavController, userListNavController]
    }
}
