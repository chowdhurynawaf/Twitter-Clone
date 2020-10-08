//
//  ExploreController.swift
//  Twitter Clone App
//
//  Created by as on 9/16/20.
//  Copyright © 2020 nawaf. All rights reserved.
//

import UIKit


class ExploreController: UITableViewController {
    
    let reusableIdentifier = "UserCell"

    
    // MARK: - Properties
    
    private var users  = [User]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var filtereduser = [User]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    var isOnSearchMode : Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    

    
    
    
    // MARK: - LifeCycle


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       configureUI()
        fetchUsers()
        configureSearchController()

    }
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(true)
          navigationController?.navigationBar.barStyle = .default
          navigationController?.navigationBar.isHidden = false
      }
    
    
    //MARK: - API
    
    func fetchUsers() {
        
        UserService.shared.fetchUsers { (users) in
          
            self.users = users
            
        }
    }
    
    
    // MARK: - Helpers

    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "Explore"
        
        
        tableView.register(UserCell.self, forCellReuseIdentifier: reusableIdentifier)
        tableView.rowHeight = 60
        tableView.separatorStyle = .none
        
    
    }
    
    func configureSearchController() {
        
        searchController.searchResultsUpdater = self //UISearchResultsUpdating protocl
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
 

}


//MARK: - tableViewDataSource/Delegate


extension ExploreController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isOnSearchMode ? filtereduser.count : users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath) as! UserCell
        let user = isOnSearchMode ? filtereduser[indexPath.row] : users[indexPath.row]
        cell.user = user
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = isOnSearchMode ? filtereduser[indexPath.row] : users[indexPath.row]
        let controller = ProfileController(user: user)
        navigationController?.pushViewController(controller, animated: true)

    }
}


//MARK: - UISearchResultsUpdating

// this protocol helps to show automatic search result
extension ExploreController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText =  searchController.searchBar.text?.lowercased() else {return}
        
        filtereduser = users.filter({ $0.userName.contains(searchText) || $0.fullname.contains(searchText) })
    }
    
    
}
