//
//  FavoritesViewModel.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/8/2.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

protocol MyFavoriteListViewModelDelegate {
    func viewModel(_ viewModel: FavoritesViewModel, didUpdateFavorites: [YouBikeStation])
}

class FavoritesViewModel {
    private(set) var favorites = [YouBikeStation]() {
        didSet {
            delegate?.viewModel(self, didUpdateFavorites: favorites)
        }
    }
    
    private var stations = [String: YouBikeStation]() {
        didSet {
            favorites = stations
                .filter { (dictionary) -> Bool in
                    return favoriteIDs.contains(dictionary.key)
                }
                .map({ (dictionary) -> YouBikeStation in
                    return dictionary.value
                })
        }
    }
    
    private var favoriteIDs = Set<String>() {
        didSet {
            favorites = stations
                .filter { (dictionary) -> Bool in
                    return favoriteIDs.contains(dictionary.key)
                }
                .map({ (dictionary) -> YouBikeStation in
                    return dictionary.value
                })
        }
    }
    
    var delegate: MyFavoriteListViewModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(processingDataToArray(_:)), name: NSNotification.Name(rawValue: "Get Data"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(favoritesUpdates(_:)), name: NSNotification.Name(rawValue: "FavoritesUpdates"), object: nil)
        
        if let array = UserDefaults.standard.array(forKey: "favoriteIDs") as? [String] {
            favoriteIDs = Set(array)
        }
    }
    
    @objc
    func processingDataToArray(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            if let stations = userInfo["stations"] as? [String: YouBikeStation] {
                self.stations = stations
            }
        }
    }
    
    @objc
    func favoritesUpdates(_ notification: Notification) {
        if let array = UserDefaults.standard.array(forKey: "favoriteIDs") as? [String] {
            favoriteIDs = Set(array)
        }
    }
}
