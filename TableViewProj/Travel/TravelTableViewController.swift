//
//  TravelTableViewController.swift
//  TableViewProj
//
//  Created by cho on 1/8/24.
//

import UIKit
import Kingfisher

class TravelTableViewController: UITableViewController {
    
    @IBOutlet var topBackView: UIView!
    @IBOutlet var underline: UIView!
    @IBOutlet var topTItle: UILabel!
    
    let magazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        underline.layer.borderWidth = 1
        underline.layer.borderColor = UIColor.lightGray.cgColor
        tableView.separatorStyle = .none

        topBackView.backgroundColor = .white
        topTItle.text = "Travel Magazine"
        topTItle.textAlignment = .center
        topTItle.font = .boldSystemFont(ofSize: 20)
        tableView.rowHeight = 400
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
        
        let data = magazine[indexPath.row]
        let url = URL(string: data.photo_image)
        
        cell.configureCell(data: data)
        
        cell.mainImageView.kf.setImage(with: url)
        
//        cell.mainImageView.contentMode = .scaleAspectFit
//        
//        cell.mainTitle.font = .boldSystemFont(ofSize: 20)
//        cell.mainTitle.numberOfLines = 0
//        
//        cell.subTitle.font = .systemFont(ofSize: 14)
//        cell.subTitle.textColor = .gray
//        
//        cell.date.font = .systemFont(ofSize: 12)
//        cell.date.textColor = .gray
        
        return cell
    }

    @objc func cellTapped(sender: UIButton) {
        print(sender.tag)
    }

}

