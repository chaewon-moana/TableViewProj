//
//  CityCollectionViewCell.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.layer.cornerRadius = cityImageView.frame.height/2
        cityImageView.layer.borderWidth = 1
        cityImageView.layer.borderColor = UIColor.clear.cgColor
        cityImageView.clipsToBounds = true
        
        mainLabel.textAlignment = .center
        mainLabel.font = .boldSystemFont(ofSize: 14)
        
        subLabel.font = .systemFont(ofSize: 10)
        subLabel.textColor = .gray
        subLabel.textAlignment = .center
        subLabel.numberOfLines = 0
        
    }

}
