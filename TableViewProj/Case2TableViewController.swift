//
//  Case2TableViewController.swift
//  TableViewProj
//
//  Created by cho on 1/7/24.
//

import UIKit

class Case2TableViewController: UITableViewController {
    
    var sectionList = ["전체 설정", "개인 설정", "기타"]
//    var cellList: [[String]] = [["공지사항", "실험실", "버전 정보"],
//                                ["개인/보안", "알림", "채팅", "멀티프로필"],
//                                ["고객센터/도움말"]
//    ]
    var cellList: [[String]] = [["dd","asd","dddd","ddddddd"],
                                ["11", "22", "33"],
                                ["d","ddd","ddddd"]
    
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Case2TableViewController")!
        
        cell.textLabel?.text = cellList[indexPath.section][indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 14)
    
//        if indexPath.section == 0 {
//            cell.textLabel?.text = cellList[indexPath.section][indexPath.row]
//        } else if indexPath.section == 1 {
//            cell.textLabel?.text = cellList[indexPath.section][indexPath.row]
//        } else {
//            cell.textLabel?.text = cellList[indexPath.section][indexPath.row]
//        }
//    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellList[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
}
