//
//  CinemaViewController.swift
//  TableViewProj
//
//  Created by cho on 1/15/24.
//

import UIKit
import CoreLocation
import MapKit

class CinemaViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    let locationManager = CLLocationManager()
    let originalList = TheaterList.mapAnnotations
    var tmpList: [Theater] = TheaterList.mapAnnotations
    
    var userLatitude: Double = 0
    var userLongitude: Double = 126.970345
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem?.title = "Filter"
        
        locationManager.delegate = self
        checkUserLocationAuthorization()
    
    }
    
    func setAlert() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let megabox = UIAlertAction(title: "메가박스", style: .default) { [self] _ in
            self.tmpList = self.originalList.filter( { $0.type == TheaterType.mega.rawValue } )
            setAnnotation(latitude: userLatitude, longitude: userLongitude, list: tmpList)
        }
        let lotte = UIAlertAction(title: "롯데시네마", style: .default) { [self] _ in
            self.tmpList = self.originalList.filter( { $0.type == TheaterType.lotte.rawValue } )
            setAnnotation(latitude: userLatitude, longitude: userLongitude, list: tmpList)
        }
        let cgv = UIAlertAction(title: "CGV", style: .default) { [self] _ in
            self.tmpList = self.originalList.filter( { $0.type == TheaterType.cgv.rawValue } )
            setAnnotation(latitude: userLatitude, longitude: userLongitude, list: tmpList)
        }
        let all = UIAlertAction(title: "전체보기", style: .default) { [self] _ in
            self.tmpList = self.originalList
            setAnnotation(latitude: userLatitude, longitude: userLongitude, list: tmpList)
        }
        

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
        
    func setAnnotation(latitude: Double, longitude: Double, list: [Theater]) {
        
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let point = MKPointAnnotation()
        point.coordinate.latitude = latitude
        point.coordinate.longitude = longitude
        point.title = "여기얌"
        mapView.addAnnotation(point)
        
        //왜 removeAnnotations는 되고,,,쟤는 안되는건가,,,
//        for item in originalList {
//            let cinema = MKPointAnnotation()
//            cinema.coordinate.latitude = item.latitude
//            cinema.coordinate.longitude = item.longitude
//            mapView.removeAnnotation(cinema)
//        }
//        
        let allAnnotation = mapView.annotations
        mapView.removeAnnotations(allAnnotation)
        
        for item in list {
            let cinema = MKPointAnnotation()
            cinema.coordinate.latitude = item.latitude
            cinema.coordinate.longitude = item.longitude
            cinema.title = item.location
            mapView.addAnnotation(cinema)
        }
        
        locationManager.startUpdatingLocation()
        
    }
    
    
    
}

extension CinemaViewController {
    //사용자의 승인상태를 확인하는 함수
    func checkUserLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() { //사용자가 위치서비스 ON
                let authorization: CLAuthorizationStatus
                //TODO:
                authorization = self.locationManager.authorizationStatus
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else { //사용자의 위치서비스 Off
                //TODO: 설정으로 이동하는 함수 필요
                print("위치서비스 꺼져있음.")
                
            }
            
        }
    }
    
    //사용자의 현재 권한 상태를 확인하는 함수
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("notDetermined")
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.requestWhenInUseAuthorization() //결정되어있지 않을 때, 권한 재요청 문구 띄우기
        case .denied:
            print("denied")
            //TODO: 거부되어있을 때, 설정화면으로 이동하게 만들기
            print("설정화면으로 이동")
            setAnnotation(latitude: 37.554921, longitude: 126.970345, list: originalList) //거부햇으면 서울역 위치로
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            //TODO: 사용자의 위치 받아와서 영화관 보여주게 만들기!
            print("승인되어있어서 내맘대로 다 할거야,,,")
            //setAnnotation(latitude: userLatitude, longitude: userLongitude, list: list)
            locationManager.startUpdatingLocation()
            
            //checkUserLocationAuthorization()
        default:
            print("사용자 권한 에러")
        }
    }
    
    //TODO: 위치 버튼을 눌렀을 때, 다시 설정할 수 있게 alert 띄우기
    func showSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스가 꺼져있습니다. [설정>개인정보보호]에서 위치서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            } else {
                print("설정으로 가는 거 에러 뜸")
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    } //위치서비스 꺼저있을 때, 설정으로 유도하는 Alert
}

//37.554921, 126.970345 -> 서울역 좌표
//37.654536, 127.049893 -> 도봉캠퍼스 좌표
//37.506831, 126.960819 -> 중앙대병원 기준 -> 6개의 영화관에서 가운데 있음
extension CinemaViewController: CLLocationManagerDelegate {
    
    //사용자 위치 가져온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        if let coordinate = locations.last?.coordinate {
            print(#function)
            userLatitude = coordinate.latitude
            userLongitude = coordinate.longitude
            setAnnotation(latitude: coordinate.latitude, longitude: coordinate.longitude, list: tmpList)
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    //사용자의 위치 못 가져온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationAuthorization()
    }
    
}
