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
    
    var adaptor: MainSearchAdaptor!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random Users"
        UIAlertControllerView.showLoading(from: self, message: "Loading info...")
        setupSearchController()
        fetchUsers()
    }
    
    fileprivate func fetchUsers() {
        viewModel.onUpdatedData = {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.handleAdaptor()
            }
        }
        
        viewModel.onThrowError = { error in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.handleError(error)
            }
        }
        
        viewModel.fetchRandomUsers()
    }
    
    fileprivate func handleAdaptor() {
        UIAlertControllerView.hideLoading(from: self)
        let userInfo = viewModel.randomUsers?.compactMap { UserInfo($0) }.filter { $0 == $0 }
        adaptor = MainSearchAdaptor(tableView: tableView, data: userInfo!) { [weak self] user in
            self?.showUserDetails(with: user)
        }
        tableView.reloadData()
    }
    
    fileprivate func showUserDetails(with user: UserInfo) {
        //TODO:
//        guard let user = viewModel.randomUser(at: index) else { return }
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
        navigationItem.searchController = searchController
    }
}

extension MainSearchViewController: UISearchBarDelegate, UISearchControllerDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //TODO:
    }
}
