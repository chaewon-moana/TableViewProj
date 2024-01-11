//
//  SpotViewController.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit

class SpotViewController: UIViewController {
    
    static let identifier: String = "SpotViewController"

    @IBOutlet var mainTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationItem.title = "관광지 화면"
        mainTitle.text = "@@@관광지에요@@@"
        mainTitle.textAlignment = .center
        mainTitle.font = .boldSystemFont(ofSize: 30)
        
        let image = UIImage(systemName: "chevron.backward")
        let button = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = button
    }
    
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }


}
