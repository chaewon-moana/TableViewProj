//
//  CityViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit


class CityViewController: UIViewController {

    @IBOutlet var titleView: UIView!
    @IBOutlet var underLine: UIView!
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var domesticSegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    let city = CityInfo().city
    var selectSegment: Int = 0
    var list: [City] = CityInfo().city

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        
        setAttribute()
        setCollectionLayout()
       
        domesticSegment.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        selectSegment = sender.selectedSegmentIndex

        switch selectSegment {
        case 0:
            list = city
        case 1:
            list = city.filter( {$0.domestic_travel})
        case 2:
            list = city.filter( {!$0.domestic_travel})
        default:
            print("오류")
        }
    }
    
    func setCollectionLayout() {
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 20
        let cellWidth = UIScreen.main.bounds.width - spacing * 4
        let cellHeight = UIScreen.main.bounds.height - spacing * 3
        
        layout.itemSize = CGSize(width: cellWidth / 2, height: cellHeight / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 5
        
        cityCollectionView.collectionViewLayout = layout
    }
    
    func setAttribute() {
        underLine.layer.borderWidth = 1
        underLine.layer.borderColor = UIColor.gray.cgColor
        
        titleLabel.text = "인기도시"
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 14)
    }

    
}



extension CityViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityCollectionViewCell", for: indexPath) as! CityCollectionViewCell
        
        let data = list[indexPath.item]
        let url = URL(string: data.city_image)
        
        cell.cityImageView.kf.setImage(with: url)
        cell.mainLabel.text = "\(data.city_name) | \(data.city_english_name)"
        cell.subLabel.text = data.city_explain
        
        collectionView.reloadData()
       
        return cell
    }
}

extension CityViewController: UICollectionViewDataSource {
    
}
