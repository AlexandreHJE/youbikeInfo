//
//  ViewController.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/24.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit
import MapKit

class YouBikeStationsMapVC: UIViewController {

    var annotations = [MKPointAnnotation]()
    var youBikeData = [String: YouBikeStation]()
    var filteredData = [String: YouBikeStation]()
    
    
    let regionRad: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func refreshBtn(_ sender: Any) {
        makePins()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set initial location in Taipei 101
        let initialLocation = CLLocation(latitude: 25.0339639, longitude: 121.5622835)
        
        centerMapOnLocation(location: initialLocation)
        
        
        let url = URL(string: "https://tcgbusfs.blob.core.windows.net/blobyoubike/YouBikeTP.json")!
        let task = URLSession.shared.dataTask(with: url) {
            (jsonData, response, error)
            in
            let decoder = JSONDecoder()
            if let jData = jsonData, let apiReturn = try? decoder.decode(ApiReturn.self, from: jData)
            {
                print("JSON parse success!")
                self.youBikeData = apiReturn.retVal!
            }else{
                print("JSON parse failed...")
            }
        }
        task.resume()
    }

    override func viewDidAppear(_ animated: Bool) {
        makePins()
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRad, longitudinalMeters: regionRad)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func makePins(){
        for i in youBikeData.keys {
            print(i)
            let annotation = MKPointAnnotation()
            //直接轉型而沒有用NSString.doubleValue 會因為 " 123.4567 " 包含空白得到nil而崩潰
            //annotation.coordinate = CLLocationCoordinate2D(latitude: Double((youBikeData[i]?.lat!)!)! as CLLocationDegrees, longitude: Double((youBikeData[i]?.lng!)!)! as CLLocationDegrees)
            annotation.coordinate = CLLocationCoordinate2D(latitude: ((youBikeData[i]?.lat!)! as NSString).doubleValue, longitude: ((youBikeData[i]?.lng!)! as NSString).doubleValue)
            annotation.title = youBikeData[i]?.sna
            annotation.subtitle = youBikeData[i]?.ar
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
    }
}

