//
//  TravelTableViewCell.swift
//  TableViewProj
//
//  Created by cho on 1/8/24.
//

import UIKit

class TravelTableViewCell: UITableViewCell {

    @IBOutlet var backView: UIView!
    @IBOutlet var mainImageView: UIImageView!
    @IBOutlet var mainTitle: UILabel!
    @IBOutlet var subTitle: UILabel!
    @IBOutlet var date: UILabel!
    
    func configureCell(data: Magazine) {
        mainTitle.text = data.title
        subTitle.text = data.subtitle
        date.text = setDate(date: data.date)
    }
    
    
    func setDate(date: String) -> String {
        let str = date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyMMdd"
        let convertDate = dateFormatter.date(from: str)
        let result = DateFormatter()
        result.dateFormat = "yy년 MM월 dd일"
        let convert = result.string(from: convertDate!)
        
        return convert
    }

}
