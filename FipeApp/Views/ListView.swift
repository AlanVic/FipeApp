//
//  ListView.swift
//  FipeApp
//
//  Created by Mateus Rodrigues on 03/10/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import UIKit

class ListView<T: Codable>: UIView, UITableViewDataSource {
    
    let tableView = UITableView()
    var list: [Marca] = []
    var filteredCars: [Marca] = []
    var display: KeyPath<T, String>
    
    let searchViewController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchViewController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchViewController.isActive && !isSearchBarEmpty
    }
    
    init(with service: AppService, type: T.Type, display: KeyPath<T, String>) {
        self.display = display
        super.init(frame: .zero)
        setupView()
        setupSearchController()
        NetworkManager.getAll(service: service) { (list: [T]?, error) in
            if error == nil {
                self.list = list as! [Marca]
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSearchController() {
        searchViewController.obscuresBackgroundDuringPresentation = false
        searchViewController.searchBar.placeholder = "Search for cars"
        searchViewController.definesPresentationContext = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCars.count
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let marca: Marca
        if isFiltering {
            marca = filteredCars[indexPath.row]
        } else {
            marca = list[indexPath.row]
        }
        cell.textLabel?.text = marca.name
        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredCars = list.filter({ (marca) -> Bool in
            return marca.name.lowercased().contains(searchText.lowercased())
        })
    }
}


extension ListView: ViewCodable {
    
    func buildViewHierarchy() {
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.cBuild(make: .fillSuperview)
        
//        tableView
//            .anchor(top: self.topAnchor)
//            .anchor(bottom: self.bottomAnchor)
//            .anchor(left: self.leftAnchor)
//            .anchor(right: self.rightAnchor)
    }
    
    func setupAdditionalConfiguration() {
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}
