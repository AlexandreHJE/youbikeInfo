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
    
    private let viewModel = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
        self.viewModel.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ROWS: \(viewModel.favorites.count)")
        return viewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let station = viewModel.favorites[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouBikeStationsListCell", for: indexPath) as! YouBikeStationsListCell
        cell.delegate = self
        cell.favoriteButton.setTitle("RE", for: .normal)
        cell.setUI(with: station)
        cell.favoriteButton.tag = indexPath.row + 1000
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesViewController: UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
//    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension FavoritesViewController: MyFavoriteListViewModelDelegate {
    
    func viewModel(_ viewModel: FavoritesViewModel, didUpdateFavorites: [YouBikeStation]) {
        tableView.reloadData()
    }
}

extension FavoritesViewController: YouBikeStationsListCellDelegate {

    func cell(_ cell: YouBikeStationsListCell, buttonTouchUpInside button: UIButton, stationID: String?) {
        let indexPathRow = button.tag - 1000
        let station = viewModel.favorites[indexPathRow]

        if var array = UserDefaults.standard.array(forKey: "favoriteIDs") as? [String] {
            var favSet = Set(array)
            favSet.remove(station.sno!)
            UserDefaults.standard.set(Array(favSet), forKey: "favoriteIDs")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoritesUpdates"), object: self, userInfo: nil)
        } else {
            UserDefaults.standard.set([station.sno!], forKey: "favoriteIDs")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoritesUpdates"), object: self, userInfo: nil)
        }

        print("hello \(indexPathRow)")
    }
}
