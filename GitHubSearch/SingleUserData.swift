//
//  SingleUserData.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 11/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation
import SwiftyJSON

class SingleUserData {
    
    let followers: Int
    let name: String
    let created: Date
    let updated: Date
    let publicRepos: Int
    
    init(_ json: JSON){
        
        followers = json["followers"].intValue
        name = json["name"].stringValue
        //Converting string -> date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let createdString = json["created_at"].stringValue
        created = dateFormatter.date(from: createdString)!
        let updatedString = json["updated_at"].stringValue
        updated = dateFormatter.date(from: updatedString)!
        publicRepos = json["public_repos"].intValue
    }
    
}
