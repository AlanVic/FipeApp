//
//  ListView.swift
//  FipeApp
//
//  Created by Mateus Rodrigues on 03/10/19.
//  Copyright © 2019 Mateus Sales. All rights reserved.
//

import UIKit

class ListView<T: Codable>: UIView, UITableViewDataSource {
    
    private let tableView = UITableView()
    
    private var list: [T] = []
    
    var display: KeyPath<T, String>

    init(with service: AppService, type: T.Type, display: KeyPath<T, String>) {
        self.display = display
        super.init(frame: .zero)
        setupView()
        NetworkManager.getAll(service: service) { (list: [T]?, error) in
            if error == nil {
                self.list = list ?? []
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = list[indexPath.row][keyPath: display]
        return cell
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
