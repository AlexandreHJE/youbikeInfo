//
//  FavoritesViewController.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/8/2.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "YouBikeStationsListCell", bundle: nil), forCellReuseIdentifier: "YouBikeStationsListCell")
        return tableView
    }()
    
    let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
//        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.viewModel.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let station = viewModel.favorites[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ios11", for: indexPath) as! YouBikeStationsListCell
        
        cell.titleLabel?.text = station.sna
        cell.detailLabel?.text = "可使用\(station.sbi ?? "0")台・總車位\(station.tot ?? "0")"
        cell.detail2Label?.text = station.ar
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FavoritesViewController: MyFavoriteListViewModelDelegate {
    
    func viewModel(_ viewModel: FavoritesViewModel, didUpdateFavorites: [YouBikeStation]) {
        tableView.reloadData()
    }
}
