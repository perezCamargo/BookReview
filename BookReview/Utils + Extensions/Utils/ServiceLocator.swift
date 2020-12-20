//
//  ServiceLocator.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

class ServiceLocator {
    static func getService() -> LoadingView {
        return ImageLoadingView(Images.loader.templateImage)
    }
    
    static func getService() -> AppFlowController {
        return AppFlowViewController()
    }
}
