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
        weatherImageView.layer.shadowOpacity = 1
        weatherImageView.layer.shadowOffset = .zero
        weatherImageView.layer.shadowRadius = 6
        
        statusLabel.textColor = tColor
        statusLabel.layer.shadowOpacity = 1
        statusLabel.layer.shadowOffset = .zero
        statusLabel.layer.shadowRadius = 6
        
        minMaxLabel.textColor = tColor
        minMaxLabel.layer.shadowOpacity = 1
        minMaxLabel.layer.shadowOffset = .zero
        minMaxLabel.layer.shadowRadius = 6
        
        currentTemperatureLabel.textColor = tColor
        currentTemperatureLabel.layer.shadowOpacity = 1
        currentTemperatureLabel.layer.shadowOffset = .zero
        currentTemperatureLabel.layer.shadowRadius = 6
        
        weatherImageView.clipsToBounds = false
        contentView.clipsToBounds = false
        clipsToBounds = false
    }
}
