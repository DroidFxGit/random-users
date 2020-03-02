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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Random Users"
        setupSearchController()
        
        UIAlertControllerView.showLoading(from: self, message: "Loading info...")
        fetchUsers()
    }
    
    fileprivate func fetchUsers() {
        viewModel.onUpdatedData = {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.tableView.reloadData()
                UIAlertControllerView.hideLoading(from: strongSelf)
            }
        }
        
        viewModel.onThrowError = { error in
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                UIAlertControllerView.hideLoading(from: strongSelf)
                UIAlertControllerView.showAlert(from: strongSelf, title: "Error", message: error.localizedDescription)
            }
        }
        
        viewModel.fetchRandomUsers()
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
