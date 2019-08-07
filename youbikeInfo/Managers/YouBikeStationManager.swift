//
//  YouBikeStationsManager.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/8/7.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation
import MapKit.MKPointAnnotation

struct YouBikeStationManager {
    
    static func stationsToPointAnnotations(_ stations: [YouBikeStation]) -> [MKPointAnnotation] {
        //舊版寫法 改用map改寫 push後刪除
        //        var annotations = [MKPointAnnotation]()
        //        for i in 0..<stations.count {
        //            let annotation = MKPointAnnotation()
        //            annotation.coordinate = CLLocationCoordinate2D(latitude: ((stations[i].lat)! as NSString).doubleValue, longitude: ((stations[i].lng)! as NSString).doubleValue)
        //            annotation.title = stations[i].sna
        //            annotation.subtitle = stations[i].ar
        //            annotations.append(annotation)
        //        }
        //        return annotations
        
        return stations
            .map({ (station) -> MKPointAnnotation in
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: ((station.lat)! as NSString).doubleValue, longitude: ((station.lng)! as NSString).doubleValue)
                annotation.title = station.sna
                annotation.subtitle = station.ar
                return annotation
            })
    }
}

