//
//  ForecastCollectionViewCell.swift
//  ShinyDay
//
//  Created by yoonie on 2/21/25.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        let tColor = UIColor.white
        dateLabel.textColor = tColor
        timeLabel.textColor = tColor
        statusLabel.textColor = tColor
        temperatureLabel.textColor = tColor
    }
}
