//
//  CinemaViewController.swift
//  TableViewProj
//
//  Created by cho on 1/15/24.
//

import UIKit
import MapKit

class CinemaViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem?.title = "Filter"
    
    }
    
    func setAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default)
        let lotte = UIAlertAction(title: "롯데시네마", style: .default)
        let cgv = UIAlertAction(title: "CGV", style: .default)
        let all = UIAlertAction(title: "전체보기", style: .default)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(megabox)
        alert.addAction(lotte)
        alert.addAction(cgv)
        alert.addAction(all)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }

    @IBAction func rightButtonTapped(_ sender: UIBarButtonItem) {
        setAlert()
    }
    
    
    func setAnnotation() {
//        let mega = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = "여기얌여기"
//        mapView.addAnnotation(annotation)
    }
}
