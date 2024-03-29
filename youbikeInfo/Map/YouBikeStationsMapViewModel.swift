//
//  YouBikeStationsMapViewModel.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/29.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

protocol YouBikeStationsMapViewModelDelegate: NSObjectProtocol {
    func viewModel(_ viewModel: YouBikeStationsMapViewModel, didUpdateYouBikeData data: [YouBikeStation])
}

class YouBikeStationsMapViewModel {
    
    var stations = [YouBikeStation]() {
        didSet {
            delegate?.viewModel(self, didUpdateYouBikeData: stations)
        }
    }
    
    weak var delegate: YouBikeStationsMapViewModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(processingDataToArray(_:)), name: NSNotification.Name(rawValue: "Get Data"), object: nil)
    }
    
    @objc
    func processingDataToArray(_ notification: Notification) {
        if let userInfo = notification.userInfo {
            //print(userInfo)
            //print(userInfo["stations"])
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
