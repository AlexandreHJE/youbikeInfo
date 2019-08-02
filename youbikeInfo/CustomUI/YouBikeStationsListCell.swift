//
//  YouBikeStationsListCell.swift
//  youbikeInfo
//
//  Created by 胡仁恩 on 2019/7/26.
//  Copyright © 2019 alexHu. All rights reserved.
//

import UIKit

protocol YouBikeStationsListCellDelegate {
    
    func cell(_ cell: YouBikeStationsListCell, buttonTouchUpInside button: UIButton, stationID: String?)
}

class YouBikeStationsListCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detail2Label: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var stationID: String?
    var delegate: YouBikeStationsListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func buttonTouchUpInside(_ sender: UIButton) {
        delegate?.cell(self, buttonTouchUpInside: sender, stationID: stationID)
    }

    func setUI(with station: YouBikeStation) {
        stationID = station.sno
        titleLabel.text = station.sna
        detailLabel.text = "可使用\(station.sbi!)台・總車位\(station.tot!)"
        detail2Label.text = station.ar
    }
}
