//
//  DetailInfoCollectionViewCell.swift
//  ShinyDay
//
//  Created by yoonie on 2/25/25.
//

import UIKit

class DetailInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        
        let tColor = UIColor.white
        imageView.tintColor = tColor
        titleLabel.textColor = tColor
        valueLabel.textColor = tColor
        descriptionLabel.textColor = tColor.withAlphaComponent(0.5)
    }
    
}
