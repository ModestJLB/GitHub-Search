//
//  UserTableViewCell.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    let typeLabel: UILabel = {
        let type = UILabel()
        type.text = "USER"
        type.translatesAutoresizingMaskIntoConstraints = false
        return type
    }()
    
    func setupViews() {
        addSubview(userNameLabel)
        addSubview(typeLabel)
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-[v1]-8-|", options: [], metrics: nil, views: ["v0": userNameLabel, "v1": typeLabel])
        NSLayoutConstraint.activate(constraint)
    }
}
