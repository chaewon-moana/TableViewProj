//
//  TravelTableViewController.swift
//  TableViewProj
//
//  Created by cho on 1/8/24.
//

import UIKit
import Kingfisher
import WebKit

class TravelTableViewController: UITableViewController {
    
    let magazine = MagazineInfo.magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "TRAVEL MAGAZINE"
    
//        tableView.separatorStyle = .none

        tableView.rowHeight = 400
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelTableViewCell.identifier, for: indexPath) as! TravelTableViewCell
        
        let data = magazine[indexPath.row]
        let url = URL(string: data.photo_image)
        
        cell.configureCell(data: data)
        
        cell.mainImageView.kf.setImage(with: url)
        
        cell.mainImageView.contentMode = .scaleAspectFit
        
        cell.mainTitle.font = .boldSystemFont(ofSize: 20)
        cell.mainTitle.numberOfLines = 0
        
        cell.subTitle.font = .systemFont(ofSize: 14)
        cell.subTitle.textColor = .gray
        
        cell.date.font = .systemFont(ofSize: 12)
        cell.date.textColor = .gray
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: WebViewController.identifier) as! WebViewController
        vc.url = magazine[indexPath.row].link
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

