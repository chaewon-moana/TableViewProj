//
//  CityCollectionViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit
import Kingfisher

class CityCollectionViewController: UICollectionViewController {
    
    let city = CityInfo().city
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        collectionViewLayout()
    }
    
    func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        let cellWidth = UIScreen.main.bounds.width - spacing * 4
        let cellHeight = UIScreen.main.bounds.height - spacing * 3
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 3)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 10 // 셀의 세로 사이에 대한 간격
        layout.minimumInteritemSpacing = 10 // 셀의 가로 사이에 대한 간격
        
        collectionView.collectionViewLayout = layout
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as! CityCollectionViewCell
        
        let data = city[indexPath.item]
        let url = URL(string: data.city_image)
                
        cell.cityImageView.kf.setImage(with: url)
        cell.cityImageView.contentMode = .scaleAspectFill
        cell.cityImageView.layer.cornerRadius = cell.cityImageView.frame.height/2
        cell.cityImageView.layer.borderWidth = 1
        cell.cityImageView.layer.borderColor = UIColor.clear.cgColor
        cell.cityImageView.clipsToBounds = true

        cell.mainLabel.text = "\(data.city_name) | \(data.city_english_name)"
        cell.mainLabel.textAlignment = .center
        cell.mainLabel.font = .boldSystemFont(ofSize: 14)
        
        cell.subLabel.text = data.city_explain
        cell.subLabel.font = .systemFont(ofSize: 10)
        cell.subLabel.textColor = .gray
        cell.subLabel.textAlignment = .center
        cell.subLabel.numberOfLines = 0
        
        return cell
    }
    
    

}
