//
//  CityViewController.swift
//  TableViewProj
//
//  Created by cho on 1/9/24.
//

import UIKit


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

        switch selectSegment {
        case 0:
            list = originalCity
        case 1:
            list = originalCity.filter( {$0.domestic_travel})
        case 2:
            list = originalCity.filter( {!$0.domestic_travel})
        default:
            print("오류")
        }
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
        
        var string = searchBar.text!.trimmingCharacters(in: .whitespaces).lowercased()
        print(string,11)
                
        for item in originalCity {
            if item.city_name.lowercased().contains(string) || item.city_english_name.lowercased().contains(string) || item.city_explain.lowercased().contains(string) {
                filterData.append(item)
            }
        }
        
        if string == "" {
            list = originalCity
            print(1)
        }
        
        switch selectSegment {
        case 0:
            list = filterData.isEmpty ? originalCity : filterData
        case 1:
            list = filterData.isEmpty ? originalCity.filter( {$0.domestic_travel} ) : filterData.filter( {$0.domestic_travel} )
        case 2:
            list = filterData.isEmpty ? originalCity.filter( {!$0.domestic_travel} ) : filterData.filter( {!$0.domestic_travel} )
        default:
            print("오류!")
        }

        
        print(searchText)
    }
}
