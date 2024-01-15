//
//  ADViewController.swift
//  TableViewProj
//
//  Created by cho on 1/11/24.
//

import UIKit

class ADViewController: UIViewController {
    
    //static let identifier: String = "ADViewController"

    @IBOutlet var mainTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "광고 화면"
        
        mainTitle.text = "@@@광고에요!@@@"
        mainTitle.textAlignment = .center
        mainTitle.font = .boldSystemFont(ofSize: 30)
        
        
        let button = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .plain, target: self, action: #selector(XMarkTapped))
        navigationItem.leftBarButtonItem = button
    }
    
    @objc func XMarkTapped() {
        dismiss(animated: true)
    }


}
