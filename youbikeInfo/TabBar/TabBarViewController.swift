//
//  TabBarViewController.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/8/2.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let vc1 = UIStoryboard(name: "YouBikeStationsMap", bundle: nil).instantiateInitialViewController()!
        let vc2 = UIStoryboard(name: "YouBikeStationsList", bundle: nil).instantiateInitialViewController()!
        let vc3 = UIStoryboard(name: "MyFavoriteList", bundle: nil).instantiateInitialViewController()!
        
        setViewControllers([vc1, vc2, vc3], animated: false)
    }
}
