//
//  DetailViewController.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    @IBOutlet var maintableView: UITableView!
    
    let travel = TravelInfo().travel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        maintableView.delegate = self
        maintableView.dataSource = self
        
        let back = UIImage(systemName: "chevron.left")
      
        let backButton = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(backButtonTapped))
                navigationItem.leftBarButtonItem = backButton
        
        let detailXIB = UINib(nibName: "DetailTableViewCell", bundle: nil)
        maintableView.register(detailXIB, forCellReuseIdentifier: "DetailTableViewCell")
        
        let ADXIB = UINib(nibName: "ADTableViewCell", bundle: nil)
        maintableView.register(ADXIB, forCellReuseIdentifier: "ADTableViewCell")

    }
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
 
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(travel.count)
        return travel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = travel[indexPath.row]

        if data.ad == true {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ADTableViewCell", for: indexPath) as! ADTableViewCell
            
            cell.mainView.backgroundColor = .gray
            cell.mainView.layer.cornerRadius = 12
            
            cell.mainLabel.text = data.title
            cell.mainLabel.textAlignment = .center
            cell.mainLabel.font = .systemFont(ofSize: 16)
            
            cell.ADMark.text = "AD"
            cell.ADMark.backgroundColor = .white
            cell.ADMark.clipsToBounds = true
            cell.ADMark.layer.cornerRadius = 8
            cell.ADMark.layer.borderWidth = 1
            cell.ADMark.layer.borderColor = UIColor.clear.cgColor
            cell.ADMark.textAlignment = .center
            cell.ADMark.font = .systemFont(ofSize: 12)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            
            let url = URL(string: data.travel_image ?? "")
            cell.mainLabel.text = data.title
            cell.mainLabel.font = .boldSystemFont(ofSize: 16)
            cell.mainLabel.textColor = .black
            
            cell.subLabel.text = data.description
            cell.subLabel.font = .systemFont(ofSize: 13)
            cell.subLabel.textColor = .gray
            cell.subLabel.numberOfLines = 0
            
            cell.mainImageView.kf.setImage(with: url)
            cell.mainImageView.contentMode = .scaleToFill
            cell.mainImageView.layer.cornerRadius = 8
        
            
            let cnt = Int(round(data.grade!))
            
            for i in 0...cell.starList.count - 1 {
                if i < cnt {
                    cell.starList[i].image = UIImage(systemName: "star.fill")
                } else {
                    cell.starList[i].image = UIImage(systemName: "star")
                }
                cell.starList[i].tintColor = .systemYellow
                cell.starList[i].contentMode = .scaleAspectFit
            }
            
            cell.detailLabel.text = "(\(Int.random(in: 1...100))) · 저장 \(data.save!)"
            cell.detailLabel.font = .systemFont(ofSize: 10)
            cell.detailLabel.textColor = .gray
         
            let heartImage = data.like! ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartMark.image = heartImage
            cell.heartMark.tintColor = .systemPink
            return cell
        }
 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travel[indexPath.row].ad {
            return Travel.ADHeight
        } else {
            return Travel.cellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        
        if travel[indexPath.row].ad {
            let vc = sb.instantiateViewController(identifier: "ADViewController") as! ADViewController
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            navigationController?.present(nav, animated: true)
 
        } else {
            let vc = sb.instantiateViewController(withIdentifier: "SpotViewController") as! SpotViewController
            navigationController?.pushViewController(vc, animated: true)

        }
        
        tableView.reloadRows(at: [indexPath], with: .fade)
    }
}
