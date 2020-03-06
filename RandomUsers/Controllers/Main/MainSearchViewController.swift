//
//  MainSearchViewController.swift
//  RandomUsers
//
//  Created by Carlos Vázquez Gómez on 26/02/20.
//  Copyright © 2020 droidfx. All rights reserved.
//

import UIKit

final class MainSearchViewController: UIViewController {
    private let searchController = UISearchController(searchResultsController: nil)
    private let viewModel = MainSearchViewModel()
    
    var isSearching: Bool = false
    var adaptor: MainSearchAdaptor!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random Users"
        UIAlertControllerView.showLoading(from: self, message: "Loading info...")
        setupSearchController()
        fetchUsers()
    }
    
    func fetchUsers() {
        viewModel.onUpdatedData = {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.handleAdaptor(with: strongSelf.viewModel.randomUsers)
            }
        }
        
        viewModel.onThrowError = { error in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.handleError(error)
            }
        }
        
        if !isSearching {
            viewModel.fetchRandomUsers()
        }
    }
    
    fileprivate func handleAdaptor(with users: [RandomUser]) {
        UIAlertControllerView.hideLoading(from: self)
        let userInfo = users.compactMap { UserInfo($0) }.filter { $0 == $0 }
        adaptor = MainSearchAdaptor(tableView: tableView, data: userInfo, { [weak self] in
            self?.fetchUsers()
        }, { [weak self] user in
            self?.showUserDetails(with: user)
        })
        
        adaptor.onBeginDragging = {
            self.searchController.searchBar.endEditing(true)
        }
        tableView.reloadData()
    }
    
    fileprivate func showUserDetails(with user: UserInfo) {
        let detailView = UserDetailViewController()
        detailView.user = user
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    fileprivate func handleError(_ error: Error) {
        UIAlertControllerView.hideLoading(from: self) {
            UIAlertControllerView.showAlert(from: self, title: "Error",
                                            message: error.localizedDescription)
        }
    }
    
    fileprivate func setupSearchController() {
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}

extension MainSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = !searchText.isEmpty
        let users = viewModel.randomUsers
        let filteredUsers = searchText.isEmpty ? users : users.filter({ user -> Bool in
            return user.email.range(of: searchText, options: .caseInsensitive) != nil ||
                   user.name.first.range(of: searchText, options: .caseInsensitive) != nil ||
                   user.name.last.range(of: searchText, options: .caseInsensitive) != nil
        })
        handleAdaptor(with: filteredUsers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        handleAdaptor(with: viewModel.randomUsers)
    }
}
