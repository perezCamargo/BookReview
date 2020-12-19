//
//  APIManager.swift
//  BookReview
//
//  Created by Delberto Martinez Salazar on 1/31/19.
//  Copyright © 2019 Televisa. All rights reserved.
//

import Foundation
//import SwiftyJSON

class APIManager: NSObject {
    
    //Set the main URL
    let USER_URL = "http://jsonplaceholder.typicode.com/users"
    let REVIEWS_URL = "http://jsonplaceholder.typicode.com/posts"
      static let sharedInstance = APIManager()
    
    //Display all the users
    func getTheUsers(onSuccess: @escaping(UsersResponse) -> Void) {
        
        var usersResponse : UsersResponse = UsersResponse()
        
        guard let url = URL(string: USER_URL) else {return}
        var  request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
         
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String,AnyObject>]
                    print(json)
                   
                    
                    for element in json {
                        var user : UsersData = UsersData()
                        if let id = element["id"] as? Int {
                            user.id = id
                         
                        }
                        if let name = element["name"] as? String {
                                user.name = name
                            
                        }
                        
                        usersResponse.data.append(user)
                        
                        
                    }
                    
                    onSuccess(usersResponse)
                } catch {
                    onSuccess(usersResponse)
                }
            }
            if(error != nil){
                onSuccess(usersResponse)
            } else{
            }
        })
        task.resume()
    }
    
    //Display all the reviews.
    func getTheReviews(onSuccess: @escaping(ReviewsResponse) -> Void) {
        
        var reviewsResponse : ReviewsResponse = ReviewsResponse()
        
        guard let url = URL(string: REVIEWS_URL) else {return}
        var  request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String,AnyObject>]
                    print(json)
                    
                    
                    for element in json {
                        var reviews : ReviewsData = ReviewsData()
                        if let title = element["title"] as? String {
                            reviews.title = title
                            
                        }
                        
                        if let body = element["body"] as? String {
                            reviews.body = body
                            
                        }
                        
                        if let id = element["id"] as? Int {
                            reviews.id = id
                        }
                        
                        reviewsResponse.data.append(reviews)
                        
                        
                    }
                    
                    onSuccess(reviewsResponse)
                } catch {
                    onSuccess(reviewsResponse)
                }
            }
            if(error != nil){
                onSuccess(reviewsResponse)
            } else{
            }
        })
        task.resume()
    }
    
    //Display the Detail of the review
    func getDetailReview(id: Int, onSuccess: @escaping(ReviewDetailResponse) -> Void) {
        
        var reviewsDetailResponse : ReviewDetailResponse = ReviewDetailResponse()
        
        guard let url = URL(string: "\(REVIEWS_URL)/\(id)") else {return}
        var  request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String,AnyObject>
                    if let title = json["title"] as? String {
                        reviewsDetailResponse.title = title
                    }
                    if let body = json["body"] as? String {
                        reviewsDetailResponse.body = body
                    }
 
                    onSuccess(reviewsDetailResponse)
                } catch {
                    onSuccess(reviewsDetailResponse)
                }
            }
            if(error != nil){
                onSuccess(reviewsDetailResponse)
            } else{
            }
        })
        task.resume()
    }
    
    //Display the reviews by user.
    func getTheReviewsForUser(id: Int, onSuccess: @escaping(ReviewsResponse) -> Void) {
        
        var reviewsResponse : ReviewsResponse = ReviewsResponse()
        
        guard let url = URL(string: "\(USER_URL)/\(id)/posts") else {return}
        var  request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, error -> Void in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [Dictionary<String,AnyObject>]
                    print(json)
                    
                    
                    for element in json {
                        var reviews : ReviewsData = ReviewsData()
                        if let title = element["title"] as? String {
                            reviews.title = title
                            
                        }
                        
                        if let body = element["body"] as? String {
                            reviews.body = body
                            
                        }
                        
                        if let id = element["id"] as? Int {
                            reviews.id = id
                        }
                        
                        reviewsResponse.data.append(reviews)
                        
                        
                    }
                    
                    onSuccess(reviewsResponse)
                } catch {
                    onSuccess(reviewsResponse)
                }
            }
            if(error != nil){
                onSuccess(reviewsResponse)
            } else{
            }
        })
        task.resume()
    }
    
}
