//
//  UserDetailViewController.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 12/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class UserDetailViewController: UIViewController{

    let user: UserData
    var singleUserData: SingleUserData?

    init(user: UserData) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
        
        //Single user data
        RequestProvider.instance.getSingleUser(userLogin: user.userName, userDownloaded: {user in
            self.singleUserData = user
        }, error: {error in
            print("error with single user request")
        })
        
        //User stars quantity
        RequestProvider.instance.getStars(userLogin: user.userName, quantityDownloaded: {quantity in
            self.stars.text = "Stars: \(quantity)"
            //FIX-ME: Only 30 stars. Api sends only 30 results.
        }, error: {error in
            print("error with quantity of stars")
        })
        
        title = "User: \(user.userName)"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented")
    }
    
    //Avatar and info views
    let userAvatar = UIImageView(frame: CGRect.zero)
    let nameLabel = UILabel(frame: CGRect.zero)
    let followers = UILabel(frame: CGRect.zero)
    let nameFull = UILabel(frame: CGRect.zero)
    let created = UILabel(frame: CGRect.zero)
    let updated = UILabel(frame: CGRect.zero)
    let publicRepos = UILabel(frame: CGRect.zero)
    let stars = UILabel(frame: CGRect.zero)
    
    override func loadView() {
        view = UIView(frame: CGRect.zero)
        view.backgroundColor = UIColor.white
        view.addSubview(userAvatar)
        view.addSubview(nameLabel)
        view.addSubview(followers)
        view.addSubview(nameFull)
        view.addSubview(stars)
        view.addSubview(created)
        view.addSubview(updated)
        view.addSubview(publicRepos)
        
        nameLabel.text = "User name: \(user.userName)"
        nameFull.text = "Full name: \(singleUserData!.name)"
        followers.text = "Followers: \(singleUserData!.followers)"
        publicRepos.text = "Public repos: \(singleUserData!.publicRepos)"
        created.text = "Created at: \(singleUserData!.created)"
        updated.text = "Updated at: \(singleUserData!.updated)"
        userAvatar.sd_setImage(with: URL(string: user.avatarURL), placeholderImage: #imageLiteral(resourceName: "placeholder"))
    }
    
    //Fix constraints for horizontal and vertical size classes
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
           
            userAvatar.snp.removeConstraints()
            nameLabel.snp.removeConstraints()
            followers.snp.removeConstraints()
            nameFull.snp.removeConstraints()
            stars.snp.removeConstraints()
            created.snp.removeConstraints()
            updated.snp.removeConstraints()
            publicRepos.snp.removeConstraints()
            
            userAvatar.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(300)
                make.top.equalTo(self.view).offset(65)
            }
            nameLabel.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(80, 13, 0, 0))
            }
            nameFull.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(120, 13, 0, 0))
            }
            followers.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(160, 13, 0, 0))
            }
            publicRepos.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(200, 13, 0, 0))
            }
            stars.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(240, 13, 0, 0))
            }
            created.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(280, 13, 0, 0))
            }
            updated.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(320, 13, 0, 0))
            }
        } else {
            userAvatar.snp.removeConstraints()
            nameLabel.snp.removeConstraints()
            followers.snp.removeConstraints()
            nameFull.snp.removeConstraints()
            stars.snp.removeConstraints()
            created.snp.removeConstraints()
            updated.snp.removeConstraints()
            publicRepos.snp.removeConstraints()

            userAvatar.snp.makeConstraints { (make) -> Void in
                make.size.equalTo(300)
                make.top.equalTo(self.view).offset(65)
            }
            nameLabel.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(0, 313, 0, 0))
            }
            nameFull.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(40, 313, 0, 0))
            }
            followers.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(80, 313, 0, 0))
            }
            publicRepos.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(120, 313, 0, 0))
            }
            stars.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(160, 313, 0, 0))
            }
            created.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(200, 313, 0, 0))
            }
            updated.snp.makeConstraints { (make) -> Void in
                make.edges.equalTo(self.view).inset(UIEdgeInsetsMake(240, 313, 0, 0))
            }
        }
    }


}
