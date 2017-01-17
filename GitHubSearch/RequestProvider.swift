//
//  RequestProvider.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RequestProvider{
    
//static -> can’t be overridden by subclasses
    static let instance = RequestProvider()
    
//weak -> weak reference is just a pointer to an object that doesn't protect the object from being deallocated by ARC.
    weak var userQueryRequest: DataRequest?
    weak var repoQueryRequest: DataRequest?
    
    let apiURL = "https://api.github.com/"
    let headers = ["Authorization": "token 0dc6a32527a728afece8cf2c29401c5293f377a8"]
    let searchUsers = "search/users?q="
    let searchSingleUser = "users/"
    let searchRepos = "search/repositories?q="
    let searchSingleRepo = "repos/"
    let stars = "/starred"

// private -> This makes sure your singletons are truly unique and prevents outside objects from creating their own instances of your class through virtue of access control.
    private init(){
    }
    
    //Clear requests
    func cancelAllRequests(){
        repoQueryRequest?.cancel()
        userQueryRequest?.cancel()
    }
    
    //Get users from GitHub Api via Alamofire
    func getUsers(query: String, usersDownloaded: @escaping (_ userInfo: [UserData]) -> Void, error: @escaping (_ error: String) -> Void){
        
    //Encode query
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let userURL = apiURL + searchUsers + queryEncoded!
        userQueryRequest?.cancel()
        let request = Alamofire.request(userURL, headers: headers)
        userQueryRequest = request
    //Users.json via SwiftyJSON
        request.responseJSON(completionHandler: {response in
            debugPrint(response)
            if let resultValue = response.result.value{
                let json = JSON(resultValue)
                if let errorMessage = json["message"].string{
                    error(errorMessage)
                }
                else{
                    let items = json["items"].arrayValue
                    var foundUsers: [UserData] = []
                    for item in items{
                        foundUsers.append(UserData(item))
                    }
                    usersDownloaded(foundUsers)
                }
            }
        })
        
    }
    
    //GET REPOS
    func getRepos(query: String, reposDownloaded: @escaping (_ repoInfo: [RepoData]) -> Void, error: @escaping (_ error: String) -> Void){
        let queryEncoded = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let repoURL = apiURL + searchRepos + queryEncoded!
        repoQueryRequest?.cancel()
        let request = Alamofire.request(repoURL, headers: headers)
        repoQueryRequest = request
        request.responseJSON(completionHandler: {response in //request for repo data
            debugPrint(response)
            if let resultValue = response.result.value{
                let json = JSON(resultValue)
                let items = json["items"].arrayValue
                var foundRepos: [RepoData] = []
                for item in items{
                    foundRepos.append(RepoData(item))
                    }
                reposDownloaded(foundRepos)
            }
        })
    }
    
    //GET SINGLE USER
    func getSingleUser(userLogin: String, userDownloaded: @escaping (_ userInfo: SingleUserData) -> Void, error: @escaping (_ error: String) -> Void){
        let singleUserURL = apiURL + searchSingleUser + userLogin
        let request = Alamofire.request(singleUserURL, headers: headers)
        request.responseJSON(completionHandler: {response in //request for single user data
            debugPrint(response)
            if let resultValue = response.result.value{
                let json = JSON(resultValue)
                if let errorMessage = json["message"].string{
                    error(errorMessage)
                }
                else{
                    userDownloaded(SingleUserData(json))
                }
            }
        })
     }
     
    //GET SINGLE REPO
    func getSingleRepo(userLogin: String, repoName: String, repoDownloaded: @escaping (_ repoInfo: SingleRepoData) -> Void, error: @escaping (_ error: String) -> Void){
        let singleRepoURL = apiURL + searchSingleRepo + userLogin + "/" + repoName
        let request = Alamofire.request(singleRepoURL, headers: headers)
        request.responseJSON(completionHandler: {response in //request for single repo data
            debugPrint(response)
            if let resultValue = response.result.value {
                    let json = JSON(resultValue)
                    if let errorMessage = json["message"].string
                    { error(errorMessage) }
                else
                    { repoDownloaded(SingleRepoData(json)) }
            }
        })
     }
    
    //GET STARS FOR USER
    func getStars(userLogin: String, quantityDownloaded: @escaping (_ quantity: Int) -> Void, error: @escaping (_ error: String) -> Void){
        let starsURL = apiURL + searchSingleUser + userLogin + stars
        let request = Alamofire.request(starsURL, headers: headers)
        request.responseJSON(completionHandler: {response in
            debugPrint(response)
            if let resultValue = response.result.value{
                    let json = JSON(resultValue)
                    if let errorMessage = json["message"].string{
                    error(errorMessage) }
                else
                { quantityDownloaded(json.arrayValue.count) }
                }
        })
    }

}
