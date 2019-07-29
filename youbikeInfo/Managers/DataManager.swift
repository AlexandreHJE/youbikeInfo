//
//  DataManager.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/26.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation

class DataManager {
    static let shared = DataManager()
}

extension DataManager {
    
    func getYouBikeStations(_ completion: @escaping ([String: YouBikeStation]) -> Void) {
        let url = URL(string: "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json")!
//        let url = Bundle.main.url(forResource: "youbikeJSON", withExtension: "txt")
        let task = URLSession.shared.dataTask(with: url) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let apiReturn = try? decoder.decode(ApiReturn.self, from: jData)
            {
                print("JSON parse success!")
                DispatchQueue.main.sync {
                    //                    self.youBikeData = apiReturn.retVal!
                    completion(apiReturn.value!)
                    var sections = [String: [YouBikeStation]]()
                    
                    let stations = apiReturn.value!
                    var temps = [YouBikeStation]()
                    for k in stations.keys {
                        temps.append(stations[k]!)
                    }
                    
                    for station in temps {
                        if sections[station.sarea!] == nil {
                            sections[station.sarea!] = [station]
                        } else {
                            sections[station.sarea!]?.append(station)
                        }
                    }
                }
            }else{
                print("JSON parse failed...")
            }
        }
        task.resume()
    }
    
    func getStations(_ block: ([YouBikeStation]) -> Void) {
        // API
        block([YouBikeStation]())
    }
    
    func getNumbers(_ block: ([Int]) -> Void) {
        let numbers = (0..<5).map { (_) -> Int in
            return Int(arc4random_uniform(6))
        }
        
        block(numbers)
    }
}


