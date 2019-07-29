//
//  apiModel.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/24.
//  Copyright © 2019 alexHu. All rights reserved.
//

import Foundation
import MapKit

struct Response: Decodable {
    
    var retCode: Int?
    var values: [YouBikeStation]
    
    enum CodingKeys: String, CodingKey {
        case retCode = "retCode"
        case retVal = "retVal"
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        retCode = try value.decode(Int.self, forKey: .retCode)
        let retValues = try value.decode([String: YouBikeStation].self, forKey: .retVal)
        var temps = [YouBikeStation]()
        for k in retValues.keys {
            temps.append(retValues[k]!)
        }
        temps.sort { (lhs, rhs) -> Bool in
            return lhs.sno! > rhs.sno!
        }
        values = temps
    }
}

class ApiReturn: NSObject, Codable {
    var retCode: Int?
    var value: [String : YouBikeStation]?

    enum CodingKeys: String, CodingKey {
        case retCode = "retCode"
        case value = "retVal"
    }
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
