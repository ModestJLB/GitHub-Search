//
//  RepoTableViewCell.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.frame.size.width = 150
        label.sizeToFit()
        return label
    }()
    
    let typeLabel: UILabel = {
        let type = UILabel()
        type.text = "REPO"
        type.translatesAutoresizingMaskIntoConstraints = false
        return type
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(typeLabel)
        let constraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-[v1]-8-|", options: [], metrics: nil, views: ["v0": titleLabel, "v1": typeLabel])
        NSLayoutConstraint.activate(constraint)
    }
}
