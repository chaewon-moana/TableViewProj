//
//  DetailTableViewCell.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit
import Kingfisher

class DetailTableViewCell: UITableViewCell {

    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var starList: [UIImageView]!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var heartMark: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainLabel.font = .boldSystemFont(ofSize: 16)
        mainLabel.textColor = .black
        
        subLabel.font = .systemFont(ofSize: 13)
        subLabel.textColor = .gray
        subLabel.numberOfLines = 0
        
        mainImageView.contentMode = .scaleToFill
        mainImageView.layer.cornerRadius = 8
        
        detailLabel.font = .systemFont(ofSize: 10)
        detailLabel.textColor = .gray
        
        heartMark.tintColor = .systemPink
    }

    
    func configureCell(data: Travel) {
        
        let url = URL(string: data.travel_image ?? "")
        let heartImage = data.like! ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        heartMark.image = heartImage
        mainLabel.text = data.title
        subLabel.text = data.description
        mainImageView.kf.setImage(with: url)
        detailLabel.text = "(\(Int.random(in: 1...100))) · 저장 \(data.save!)"
        setStarMark(starCount: Int(round(data.grade!)))

    }
    
    func setStarMark(starCount: Int) {
        for i in 0...starList.count - 1 {
            if i < starCount {
                starList[i].image = UIImage(systemName: "star.fill")
            } else {
                starList[i].image = UIImage(systemName: "star")
            }
            starList[i].tintColor = .systemYellow
            starList[i].contentMode = .scaleAspectFit
        }
    }
    

    
}
