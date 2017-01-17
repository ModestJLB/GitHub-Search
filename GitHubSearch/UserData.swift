//
//  UserData.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserData {
    
    let id: Int
    let userName: String
    let avatarURL: String
    
    init(_ json: JSON){
        id = json["id"].intValue
        userName = json["login"].stringValue
        avatarURL = json["avatar_url"].stringValue
    }
    
}
