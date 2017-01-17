//
//  SingleRepoData.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 11/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation
import SwiftyJSON

class SingleRepoData {
    
    let fullName: String
    let description: String
    let name: String
    let avatarURL: String
    let owner: String
    var language: String
    
    let created: Date
    let updated: Date

    
    init(_ json: JSON){
        
        fullName = json["full_name"].stringValue
        description = json["description"].stringValue
        name = json["name"].stringValue
        owner = json["owner"]["login"].stringValue
        language = json["language"].stringValue
        if language == "" {
            language = "N/A"
        }
        avatarURL = json["owner"]["avatar_url"].stringValue
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let createdString = json["created_at"].stringValue
        created = dateFormatter.date(from: createdString)!
        let updatedString = json["updated_at"].stringValue
        updated = dateFormatter.date(from: updatedString)!

    }
    
}
