//
//  apiModel.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/24.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation
import MapKit


class ApiReturn: NSObject, Codable {
    var retCode: Int?
    var retVal: [String : YouBikeStation]?
}

class YouBikeStation: NSObject, Codable {
    var sno: String?
    var sna: String?
    var tot: String?
    var sbi: String?
    var sarea: String?
    var mday: String?
    var lat: String?
    var lng: String?
    var ar: String?
    var sareaen: String?
    var snaen: String?
    var aren: String?
    var bemp: String?
    var act: String?
}

//struct ApiReturn: Codable {
//    var retCode: Int?
//    var retVal: [String : YouBikeStation]?
//}
//
//struct YouBikeStation: Codable {
//    var sno: String?
//    var sna: String?
//    var tot: String?
//    var sbi: String?
//    var sarea: String?
//    var mday: String?
//    var lat: String?
//    var lng: String?
//    var ar: String?
//    var sareaen: String?
//    var snaen: String?
//    var aren: String?
//    var bemp: String?
//    var act: String?
//}
