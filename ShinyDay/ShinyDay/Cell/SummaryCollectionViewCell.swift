//
//  SummaryCollectionViewCell.swift
//  ShinyDay
//
//  Created by yoonie on 2/21/25.
//

import UIKit

class SummaryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var minMaxLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    override func awakeFromNib() {
        let tColor = UIColor.white
        statusLabel.textColor = tColor
        minMaxLabel.textColor = tColor
        currentTemperatureLabel.textColor = tColor
    }
}
