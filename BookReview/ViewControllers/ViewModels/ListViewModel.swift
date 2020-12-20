//
//  ListViewModel.swift
//  BookReview
//
//  Created by Felipe Arturo. Perez Camargo on 20/12/20.
//  Copyright © 2020 Televisa. All rights reserved.
//

import Foundation

protocol ListViewModel {
    typealias Bind<T> = (value: T, bind: ((T) -> Void)?)
    static var arg: ServicesArguments { get }
    var rowsBind: Bind<[UserModel]> { get set }
    var loadingBind: Bind<Bool> { get set }
    var errorBind: Bind<NetworkError> { get set }
    
    func getFeed()
}
