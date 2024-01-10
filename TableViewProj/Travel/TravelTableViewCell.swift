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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let image = mainImageView {
            image.contentMode = .scaleAspectFit
        } else {
            print("mainImageView 에러")
        }
        
        if let label = mainTitle {
            label.font = .boldSystemFont(ofSize: 20)
            label.numberOfLines = 0
        } else {
            print("mainTitle 에러")
        }
        
        if let label = subTitle {
            label.textColor = .gray
            label.font = .systemFont(ofSize: 14)
        } else {
            print("subTitle 에러")
        }
        

        if let date = date {
            date.font = .systemFont(ofSize: 12)
            date.textColor = .gray
        } else {
            print("date 에러")
        }
        
        
//        mainImageView.contentMode = .scaleAspectFit
//        
//        mainTitle.font = .boldSystemFont(ofSize: 20)
//        mainTitle.numberOfLines = 0
//    
//        subTitle.font = .systemFont(ofSize: 14)
//        subTitle.textColor = .gray
//   
//        date.font = .systemFont(ofSize: 12)
//        date.textColor = .gray
        
    }
        
    func configureCell(data: Magazine) {
        mainTitle.text = data.title
        subTitle.text = data.subtitle
        date.text = setDate(date: data.date)
        
        subTitle.textColor = .gray
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
