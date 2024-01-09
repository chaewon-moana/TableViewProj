//
//  TodoTableViewCell.swift
//  TableViewProj
//
//  Created by cho on 1/7/24.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet var mainCellView: UIView!
    @IBOutlet var checkBoxButton: UIButton!
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var starMarkButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
    }
    
}
