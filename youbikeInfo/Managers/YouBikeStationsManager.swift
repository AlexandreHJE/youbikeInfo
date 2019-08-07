//
//  YouBikeStationsManager.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/8/7.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation
import MapKit.MKPointAnnotation

struct YouBikeStationsManager {
    
    
    static func stationsToPointAnnotations(_ stations: [YouBikeStation]) -> [MKPointAnnotation] {
        
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

