//
//  UIAlertControllerExtensions.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import UIKit

extension UIAlertController {
    typealias ActionRecipe = (actionText: String, action: (() -> Void)?)
    typealias AlertRecipe = (title: String, message: String, actions: [ActionRecipe])

    static func showOkAlert(on viewController: UIViewController, recipe: AlertRecipe, completion: (() -> Void)? = nil) {
        let action = ActionRecipe(actionText: "Ok", action: nil)
        let alert = AlertRecipe(title: recipe.title, message: recipe.message, actions: [action])

        DispatchQueue.main.async {
            viewController.present(UIAlertController.buildAlert(recipe: alert), animated: true, completion: completion)
        }
    }
    
    static func showCustomAlert(on viewController: UIViewController, recipe: AlertRecipe, completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            viewController.present(UIAlertController.buildAlert(recipe: recipe), animated: true, completion: completion)
        }
    }

    private static func buildAlert(recipe: AlertRecipe) -> UIAlertController {
        let alert = UIAlertController(title: recipe.title, message: recipe.message, preferredStyle: .alert)

        for action in recipe.actions {
            let aAction = UIAlertAction(title: action.actionText, style: .default) { [action] _ in
                action.action?()
            }
            alert.addAction(aAction)
        }

        return alert
    }
}
