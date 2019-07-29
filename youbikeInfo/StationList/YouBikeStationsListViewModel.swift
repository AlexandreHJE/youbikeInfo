//
//  YouBikeStationsListViewModel.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/29.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

protocol YouBikeStationsListViewModelDelegate: NSObjectProtocol {
    
    func viewModel(_ viewModel: YouBikeStationsListViewModel, didUpdateYouBikeData data: [YouBikeStation])
}

class YouBikeStationsListViewModel {
    
    var stations = [YouBikeStation]() {
        didSet {
            delegate?.viewModel(self, didUpdateYouBikeData: stations)
        }
    }
    
    weak var delegate: YouBikeStationsListViewModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(prcessingDataToArray(_:)), name: NSNotification.Name(rawValue: "Get Data"), object: nil)
    }
    
    @objc
    func prcessingDataToArray(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            print(userInfo)
            print(userInfo["stations"])
            if let stations = userInfo["stations"] as? [String: YouBikeStation] {
                var temps = [YouBikeStation]()
                for k in stations.keys {
                    temps.append(stations[k]!)
                }
                temps.sort { (lhs, rhs) -> Bool in
                    return lhs.sno! > rhs.sno!
                }
                
                self.stations = temps
            }
        }
    }
}
