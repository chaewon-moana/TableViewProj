//
//  ADTableViewCell.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit

class ADTableViewCell: UITableViewCell {

    
    @IBOutlet var mainView: UIView!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var ADMark: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mainView.backgroundColor = UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1)
        
        mainView.layer.cornerRadius = 12
        
        mainLabel.textAlignment = .center
        mainLabel.font = .systemFont(ofSize: 16)
        
        ADMark.text = "AD"
        ADMark.backgroundColor = .white
        ADMark.clipsToBounds = true
        ADMark.layer.cornerRadius = 8
        ADMark.layer.borderWidth = 1
        ADMark.layer.borderColor = UIColor.clear.cgColor
        ADMark.textAlignment = .center
        ADMark.font = .systemFont(ofSize: 12)
    }
    
    func configureCell(data: Travel) {
        mainLabel.text = data.title

    }
    
    
}
