//
//  CityViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit

enum SegmentValue: Int, CaseIterable {
    case all
    case domestic
    case aboard
    
    var list: [City] {
        switch self {
        case.all:
            return CityInfo.city
        case .domestic:
            return CityInfo.city.filter( {$0.domestic_travel})
        case .aboard:
            return CityInfo.city.filter( {!$0.domestic_travel} )
        }
    }
}

class CityViewController: UIViewController, ConnectTableViewCell {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var domesticSegment: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    let originalCity = CityInfo.city
    var selectSegment: Int = 0
    
    var list: [City] = CityInfo.city {
        didSet {
            cityCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(SegmentValue.all.self)
        print(SegmentValue.all.rawValue)
        print(SegmentValue.allCases[0].list)

        navigationItem.title = "인기 도시"

        cityCollectionView.dataSource = self
        cityCollectionView.delegate = self
        
        searchBar.delegate = self
        
        setSearchBar()
        
        cityCollectionView.collectionViewLayout = setCollectionLayout(spacing: 20)
        setXIB()
        domesticSegment.addTarget(self, action: #selector(valueChanged), for: .valueChanged)
    }
    
    @objc func valueChanged(sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        selectSegment = sender.selectedSegmentIndex
        list = SegmentValue.allCases[sender.selectedSegmentIndex].list
    }
    
    func setXIB() {
        let xib = UINib(nibName: CityCollectionViewCell.identifier, bundle: nil)
        cityCollectionView.register(xib, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
    }
}

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        
        let data = list[indexPath.item]
        let url = URL(string: data.city_image)
        
        cell.cityImageView.kf.setImage(with: url)
        cell.mainLabel.text = "\(data.city_name) | \(data.city_english_name)"
        cell.subLabel.text = data.city_explain
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController

        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CityViewController: UISearchBarDelegate {
    func setSearchBar() {
        searchBar.searchBarStyle = .minimal
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        var filterData: [City] = []
        
        let string = searchBar.text!.trimmingCharacters(in: .whitespaces).lowercased()
        print(string,11)
                
        for item in originalCity {
            if item.city_name.lowercased().contains(string) || item.city_english_name.lowercased().contains(string) || item.city_explain.lowercased().contains(string) {
                filterData.append(item)
            }
        }
        
        if string.isEmpty {
            list = originalCity
            print(1)
        }

        list = SegmentValue.allCases[selectSegment].list
        print(searchText)
    }
}
