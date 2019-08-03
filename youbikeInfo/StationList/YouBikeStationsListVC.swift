//
//  YouBikeStationsList.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/25.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit
import MapKit

class YouBikeStationsListVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "YouBikeStationsListCell", bundle: nil), forCellReuseIdentifier: "YouBikeStationsListCell")
        return tableView
    }()
    
    @IBOutlet weak var searchBar: UISearchBar!
    private let viewModel = YouBikeStationsListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
        self.viewModel.delegate = self
    }

}

// MARK: - UITableViewDataSource
extension YouBikeStationsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let station = viewModel.stations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "YouBikeStationsListCell", for: indexPath) as! YouBikeStationsListCell
        cell.delegate = self
        cell.favoriteButton.tag = indexPath.row + 1000
        cell.setUI(with: station)

        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension YouBikeStationsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension YouBikeStationsListVC: YouBikeStationsListViewModelDelegate {
    
    func viewModel(_ viewModel: YouBikeStationsListViewModel, didUpdateYouBikeData data: [YouBikeStation]) {
        tableView.reloadData()
    }
}

extension YouBikeStationsListVC: UIPickerViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}

extension YouBikeStationsListVC: YouBikeStationsListCellDelegate {
    func cell(_ cell: YouBikeStationsListCell, buttonTouchUpInside button: UIButton, stationID: String?) {
        let indexPathRow = button.tag - 1000
        let station = viewModel.stations[indexPathRow]
        
        if var array = UserDefaults.standard.array(forKey: "favoriteIDs") as? [String] {
            var favSet = Set(array)
            if Set([stationID!]).isSubset(of: favSet){
                favSet.remove(stationID!)
                array = Array(favSet)
            } else {
                array.append(station.sno!)
            }
            UserDefaults.standard.set(array, forKey: "favoriteIDs")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoritesUpdates"), object: self, userInfo: nil)
        } else {
            UserDefaults.standard.set([station.sno!], forKey: "favoriteIDs")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "FavoritesUpdates"), object: self, userInfo: nil)
        }
//        print("ListDelegateCalled with idxRow: \(indexPathRow)")
        //print("Pressed")
    }
}

