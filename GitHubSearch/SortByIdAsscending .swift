//
//  SortByIdAsscending.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 11/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import Foundation

//Sort results by ID assending
func SortByIdAsscending (left: AnyObject, right: AnyObject) -> Bool{
    
    var leftId = 0
    var rightId = 0
    
    if let leftUser = left as? UserData { leftId = leftUser.id }
    else if let leftRepo = left as? RepoData { leftId = leftRepo.id }
    
    if let rightUser = right as? UserData { rightId = rightUser.id }
    else if let rightRepo = right as? RepoData { rightId = rightRepo.id }
    
    return leftId < rightId
}
