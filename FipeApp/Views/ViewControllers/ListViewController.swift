//
//  ListViewController.swift
//  FipeApp
//
//  Created by Mateus Rodrigues on 03/10/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import UIKit


class ListViewController: UIViewController {

    var listView = ListView(with: .getMarcas, type: Marca.self, display: \.name)
    
    override func loadView() {
        super.loadView()
        self.title = "List"
        self.view = listView
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.searchController = listView.searchViewController
        self.listView.searchViewController.searchResultsUpdater = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = listView.searchViewController.searchBar
        guard let searchText = searchBar.text else { return }
        listView.filterContentForSearchText(searchText)
        
        listView.tableView.reloadData()
    }
    
}
