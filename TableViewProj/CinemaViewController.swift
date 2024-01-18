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
    
    let list = TheaterList.mapAnnotations
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem?.title = "Filter"
        setAnnotation()
    
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
        
        let coordinate = CLLocationCoordinate2D(latitude: 37.506831, longitude: 126.960819) //중앙대학교 병원 기준
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 15000, longitudinalMeters: 15000)
        mapView.setRegion(region, animated: true)
        
        for item in list {
            let cinema = MKPointAnnotation()
            cinema.coordinate.latitude = item.latitude
            cinema.coordinate.longitude = item.longitude
            cinema.title = item.location
            mapView.addAnnotation(cinema)
        }
    }
}
