//
//  MyFavoriteListVC.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/26.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

class MyFavoriteListVC: UIViewController {

    var youBikeData = [String: YouBikeStation]()
    var myFavListData = [String]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.url(forResource: "favListJSON", withExtension: "txt")
        let url2 = Bundle.main.url(forResource: "youbikeJSON", withExtension: "txt")
        let task = URLSession.shared.dataTask(with: url!) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let favoriteList = try? decoder.decode(FavoriteList.self, from: jData)
            {
                self.myFavListData = favoriteList.myFav!
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }else{
                print("JSON parse failed...")
            }
        }
        let task2 = URLSession.shared.dataTask(with: url2!) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let apiReturn = try? decoder.decode(ApiReturn.self, from: jData)
            {
                self.youBikeData = apiReturn.value!
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }else{
                print("JSON parse failed...")
            }
        }
        task.resume()
        task2.resume()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension MyFavoriteListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFavListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.row)
        let stationID = myFavListData[indexPath.row]
        let station = youBikeData[stationID]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ios11", for: indexPath) as! YouBikeStationsListCell
        
        cell.stationName?.text = station?.sna
        cell.remainOverTotal?.text = "可使用\(station?.sbi! ?? "0")台・總車位\(station?.tot! ?? "0")"
        cell.address?.text = station?.ar
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension MyFavoriteListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99//UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

