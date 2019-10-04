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
        setupSearchController()
    }
    
    func setupSearchController() {
        let searchBar = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchBar
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
