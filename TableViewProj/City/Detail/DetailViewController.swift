//
//  DetailViewController.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit

class DetailViewController: UIViewController, ConnectTableViewCell {
    
    @IBOutlet var maintableView: UITableView!
    
    let travel = TravelInfo().travel
    var filteredHeart: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
        
        maintableView.delegate = self
        maintableView.dataSource = self
        
        setButton()
        
        setXIB()

    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setButton() {
        let back = UIImage(systemName: "chevron.left")
      
        let backButton = UIBarButtonItem(image: back, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        let right = UIBarButtonItem(image: UIImage(systemName: "heart.circle.fill"), style: .plain, target: self, action: #selector(filterHeartMark))
        navigationItem.rightBarButtonItem = right
    }
    
    @objc func filterHeartMark() {
        filteredHeart.toggle()
        maintableView.reloadData()
    }
    
    func setXIB() {
        let detailXIB = UINib(nibName: "DetailTableViewCell", bundle: nil)
        maintableView.register(detailXIB, forCellReuseIdentifier: "DetailTableViewCell")
        
        let ADXIB = UINib(nibName: "ADTableViewCell", bundle: nil)
        maintableView.register(ADXIB, forCellReuseIdentifier: "ADTableViewCell")
    }
}


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = filteredHeart ? travel.filter({ $0.like ?? false }) : travel

        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let list = filteredHeart ? travel.filter({ $0.like ?? false }) : travel
        let data = list[indexPath.row]
 
        if data.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ADTableViewCell", for: indexPath) as! ADTableViewCell
            cell.configureCell(data: data)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.configureCell(data: data)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let list = filteredHeart ? travel.filter({ $0.like ?? false }) : travel
        let data = list[indexPath.row]
        
        if data.ad {
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
