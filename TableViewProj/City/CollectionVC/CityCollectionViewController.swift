//
//  CityCollectionViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit
import Kingfisher

class CityCollectionViewController: UICollectionViewController {
    
    let city = CityInfo.city
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        
        collectionView.collectionViewLayout = setCollectionLayout(spacing: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return city.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        cell.configure(data: city[indexPath.item])
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sdsdsd")
    }
    

}
