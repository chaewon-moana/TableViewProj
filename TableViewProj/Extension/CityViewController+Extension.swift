//
//  CityViewController+Extension.swift
//  TableViewProj
//
//  Created by cho on 1/10/24.
//

import UIKit

extension CityViewController {
    
    func setCollectionLayout(spacing: CGFloat) -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        
        let cellWidth = UIScreen.main.bounds.width - spacing * 4
        let cellHeight = UIScreen.main.bounds.height - spacing * 3
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        return layout
    }
}
