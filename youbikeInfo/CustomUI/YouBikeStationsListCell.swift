//
//  YouBikeStationsListCell.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/26.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

class YouBikeStationsListCell: UITableViewCell {

    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var remainOverTotal: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
