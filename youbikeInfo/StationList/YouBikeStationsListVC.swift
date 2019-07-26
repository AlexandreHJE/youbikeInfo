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

    var youBikeData = [String: YouBikeStation]()
    var youBikeDataArray = [YouBikeStation]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let url = URL(string: "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json")!
        let url = Bundle.main.url(forResource: "youbikeJSON", withExtension: "txt")
        let task = URLSession.shared.dataTask(with: url!) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let apiReturn = try? decoder.decode(ApiReturn.self, from: jData)
            {
                print("JSON parse success!")
                self.youBikeData = apiReturn.retVal!
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            }else{
                print("JSON parse failed...")
            }
        }
        task.resume()
        print("task res")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

// MARK: - UITableViewDataSource
extension YouBikeStationsListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(youBikeData.keys.count)")
        for k in youBikeData.keys {
            youBikeDataArray.append(youBikeData[k]!)
        }
        return youBikeData.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(indexPath.row)
        let station = youBikeDataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ios11", for: indexPath) as! YouBikeStationsListCell
        
        cell.stationName?.text = station.sna
        cell.remainOverTotal?.text = "可使用\(station.sbi!)台・總車位\(station.tot!)"
        cell.address?.text = station.ar
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension YouBikeStationsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99//UITableView.automaticDimension
        //如何正常auto resize?
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}
