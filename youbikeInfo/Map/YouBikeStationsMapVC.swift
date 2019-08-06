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
    private let viewModel = YouBikeStationsMapViewModel()
    
    let districtList = [
        "中正區",
        "大同區",
        "中山區",
        "松山區",
        "大安區",
        "萬華區",
        "信義區",
        "士林區",
        "北投區",
        "內湖區",
        "南港區",
        "文山區"
    ]
    
    let regionRad: CLLocationDistance = 1000
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func refreshBtn(_ sender: Any) {
        makePins()
    }
    @IBAction func goToListBtn(_ sender: Any) {
        
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set initial location in Taipei 101
        let initialLocation = CLLocation(latitude: 25.0339639, longitude: 121.5622835)
        
        centerMapOnLocation(location: initialLocation)
        
        self.viewModel.delegate = self
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
        for i in 0..<viewModel.stations.count {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: ((viewModel.stations[i].lat)! as NSString).doubleValue, longitude: ((viewModel.stations[i].lng)! as NSString).doubleValue)
            annotation.title = viewModel.stations[i].sna
            annotation.subtitle = viewModel.stations[i].ar
            annotations.append(annotation)
        }
        //寫不出來map...
        //annotations = (viewModel.stations).map({$0.})
        mapView.addAnnotations(annotations)
    }

}

extension YouBikeStationsMapVC: YouBikeStationsMapViewModelDelegate {
    func viewModel(_ viewModel: YouBikeStationsMapViewModel, didUpdateYouBikeData data: [YouBikeStation]) {
        mapView.removeAnnotations(annotations)
        print("delegate tirggered")
        makePins()
    }
}

extension YouBikeStationsMapVC: UIPickerViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return districtList[row]
    }
}

extension YouBikeStationsMapVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return districtList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        searchBar.text = districtList[row]
    }
}

