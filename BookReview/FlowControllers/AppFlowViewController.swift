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
