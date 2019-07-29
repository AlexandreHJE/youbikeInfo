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
                self.saveYouBikeStations(apiReturn)
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
    
    //TODO: 如果API打失敗則拿本地端存放的舊資料來呈現
    func getYouBikeStationsFromLocal(_ completion: @escaping ([String: YouBikeStation]) -> Void) {
        let url = Bundle.main.url(forResource: "youbikeJSON", withExtension: "txt")
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

//存不起來
extension DataManager {
    func saveYouBikeStations(_ apiReturn: ApiReturn) {
        if apiReturn.retCode == 1 {
            let encoder: JSONEncoder = JSONEncoder()
            let encoded = try? encoder.encode(apiReturn)
            let savingData = String(data: encoded!, encoding: .utf8)
            print(savingData)
            let fileManager = FileManager.default //生成檔案管理員
            let destinationFile = NSHomeDirectory() + "/Documents/testJson.txt"
            if fileManager.fileExists(atPath: destinationFile)
            { //確認檔案是否存在
                do{
                    try savingData!.write(toFile: destinationFile, atomically: true, encoding: .utf8)
                    print("saved to txt.")
                }catch{
                    print("Unsaved...")
                }
            }
        }else{
            print("API狀態異常，不會存入資料")
        }
    }
}

extension DataManager {
    func getMyFavorite(_ completion: @escaping ([String]) -> Void) {
        let url = Bundle.main.url(forResource: "favListJSON", withExtension: "txt")
        let task = URLSession.shared.dataTask(with: url!) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let favoriteList = try? decoder.decode(FavoriteList.self, from: jData)
            {
                    let myFavListData = favoriteList.myFav!
                
            }else{
                print("JSON parse failed...")
            }
        }
        task.resume()
    }
}
