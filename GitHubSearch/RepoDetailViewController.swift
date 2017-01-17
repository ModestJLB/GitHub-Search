//
//  RepoDetailViewController.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 12/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class RepoDetailViewController: UIViewController{
    
    let repo: RepoData
    var singleRepo: SingleRepoData?
    
    init(repo: RepoData) {
        self.repo = repo
        super.init(nibName: nil, bundle: nil)
        
        //Single repo data
        RequestProvider.instance.getSingleRepo(userLogin: repo.userName, repoName: repo.repoName, repoDownloaded: {repo in
            self.singleRepo = repo
        }, error: {error in
            print("error with single user request")
        })
        
        title = "Title: \(repo.repoName)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //Repo info views
    let repoName = UILabel(frame: CGRect.zero)
    let repoDescription = UILabel(frame: CGRect.zero)
    let userAvatar = UIImageView(frame: CGRect.zero)
    let owner = UILabel(frame: CGRect.zero)
    let language = UILabel(frame: CGRect.zero)
    let created = UILabel(frame: CGRect.zero)
    let updated = UILabel(frame: CGRect.zero)
    
    override func loadView() {
        view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.addSubview(userAvatar)
        view.addSubview(owner)
        view.addSubview(repoName)
        view.addSubview(language)
        view.addSubview(repoDescription)
        view.addSubview(created)
        view.addSubview(updated)
        repoDescription.numberOfLines = 0
        repoDescription.lineBreakMode = .byWordWrapping
        repoDescription.frame.size.width = 300
        repoDescription.sizeToFit()
        
        userAvatar.sd_setImage(with: URL(string: singleRepo!.avatarURL), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        owner.text = "Owner: \(singleRepo!.owner)"
        repoName.text = "Repo name: \(singleRepo!.name)"
        language.text = "Language: \(singleRepo!.language)"
        repoDescription.text = "Description: \(singleRepo!.description)"
        created.text = "Created at: \(singleRepo!.created)"
        updated.text = "Updated at: \(singleRepo!.updated)"

    }
    
    //Fix constraints for horizontal and vertical size classes
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            owner.snp.removeConstraints()
            repoName.snp.removeConstraints()
            repoDescription.snp.removeConstraints()
            language.snp.removeConstraints()
            userAvatar.snp.removeConstraints()
            created.snp.removeConstraints()
            updated.snp.removeConstraints()
            
            userAvatar.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(300)
                make.top.equalTo(self.view).offset(65)
            }
            owner.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(80, 13, 0, 0))
            }
            repoName.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(120, 13, 0, 0))
            }
            language.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(160, 13, 0, 0))
            }
            created.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(200, 13, 0, 0))
            }
            updated.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(240, 13, 0, 0))
            }
            repoDescription.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(language).inset(UIEdgeInsetsMake(200, 0, 0, 0))
            }
        } else {
            repoName.snp.removeConstraints()
            repoDescription.snp.removeConstraints()
            owner.snp.removeConstraints()
            language.snp.removeConstraints()
            userAvatar.snp.removeConstraints()
            created.snp.removeConstraints()
            updated.snp.removeConstraints()

            userAvatar.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(300)
                make.top.equalTo(self.view).offset(65)
            }
            owner.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(-120, 313, 0, 0))
            }
            repoName.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(-80, 313, 0, 0))
            }
            language.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(-40, 313, 0, 0))
            }
            created.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 313, 0, 0))
            }
            updated.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(40, 313, 0, 0))
            }
            repoDescription.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(language).inset(UIEdgeInsetsMake(200, 0, 0, 0))
            }
        }
    }
    
}
