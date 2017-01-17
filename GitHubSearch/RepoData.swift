//
//  RepoData.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation
import SwiftyJSON

class RepoData {
    
    let id: Int
    let repoTitle: String
    let repoName: String
    let userName: String
    
    init(_ json: JSON){
        id = json["id"].intValue
        repoTitle = json["full_name"].stringValue
        repoName = json["name"].stringValue
        userName = json["owner"]["login"].stringValue
    }
    
}
