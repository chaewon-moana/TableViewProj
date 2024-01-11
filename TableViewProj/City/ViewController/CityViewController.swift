//
//  CityViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit


class CityViewController: UIViewController {

    
    @IBOutlet var domesticSegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    let city = CityInfo().city
    var selectSegment: Int = 0
    var list: [City] = CityInfo().city

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        let xib = UINib(nibName: "CityCollectionViewCell", bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: "CityCollectionViewCell")
        
        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        
        cityCollectionView.collectionViewLayout = setCollectionLayout(spacing: 20)
       
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
        cityCollectionView.reloadData()

    }
    
}


extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
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
        //print(#function)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        //let nav = UINavigationController(rootViewController: vc)
        //nav.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        //present(nav, animated: true)
        
    }
}


