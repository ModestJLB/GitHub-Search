//
//  GitHubTableViewController.swift
//  GitHubSearch
//
//  Created by Modest Mysliwski on 10/01/17.
//  Copyright © 2017 Modest Mysliwski. All rights reserved.
//

import UIKit
import Alamofire

class GitHubTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
    
    //Array from request
    var userArray: [AnyObject]?
    var repoArray: [AnyObject]?
    var resultArray: [AnyObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "GitHub Search App"
        
        //Register cells: user & repo
        tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "userCell")
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: "repoCell")

        //Creating search Bar
        self.searchController = UISearchController(searchResultsController: nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = self.searchController.searchBar
        }

    //Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Rows depends from request
    //FIX-ME table view show only 60 cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    //Creatings cells: user & repo
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let result = resultArray[indexPath.row]
        
        if let userResult = result as? UserData{
            let cell: UserTableViewCell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
            cell.userNameLabel.text = userResult.userName
            return cell
        }
        if let repoResult = result as? RepoData{
            let cell: RepoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! RepoTableViewCell
            cell.titleLabel.text = repoResult.repoName
            return cell
        }

        fatalError("error")
    }
    
    //Select row to detail views
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
        
        let user = resultArray.remove(at: indexPath.row)
        
        if user is UserData{
            searchController.isActive = false
            let userDetailViewController = UserDetailViewController(user: user as! UserData)
            navigationController?.pushViewController(userDetailViewController, animated: true)
        }
        if user is RepoData{
            searchController.isActive = false
            let repoDetailViewController = RepoDetailViewController(repo: user as! RepoData)
            navigationController?.pushViewController(repoDetailViewController, animated: true)
        }
        
    }

    //Update search results via search text
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text!
        if searchText == "" {
            RequestProvider.instance.cancelAllRequests()
            resultArray.removeAll()
            tableView.reloadData()
            return
        }
        
        //Reset arrays
        userArray = nil
        repoArray = nil
       
        //Searching requests
        //Users
        RequestProvider.instance.getUsers(query: searchText, usersDownloaded: {users in
            self.userArray = users
            self.refreshTableView()
        }, error: {error in
        })
        //Repos
        RequestProvider.instance.getRepos(query: searchText, reposDownloaded: {repos in
            self.repoArray = repos
            self.refreshTableView()
        }, error: {error in
        })
        self.resultsController.tableView.reloadData()

    }
    
    //Refresh Table View: modify var -> let
    func refreshTableView(){
        
     /*   If you’ve got a view controller with a few UITextField elements or some other type of user input, you’ll immediately notice that you must unwrap the textField.text optional to get to the text inside (if any!). isEmpty won’t do you any good here, without any input the text field will simply return nil.
        So you have a few of these which you unwrap and eventually pass to a function that posts them to a server endpoint. We don’t want the server code to have to deal with nil values or mistakenly send invalid values to the server so we’ll unwrap those input values with guard first. */
        guard let userArrayUnwrapped = userArray
            else {return}
        guard let repoArrayUnwrapped = repoArray
            else {return}
        resultArray = userArrayUnwrapped + repoArrayUnwrapped
        resultArray.sort(by: SortByIdAsscending)
        tableView.reloadData()
    //FIX-ME: Table View show only 60 cells?
    }
}


