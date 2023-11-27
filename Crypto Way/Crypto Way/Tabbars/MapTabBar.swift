////
////  Settings.swift
////  Crypto Way
////
////  Created by mac on 20.11.23.
////
//
import UIKit
import GoogleMaps
import CoreLocation

class MapController: UIViewController, GMSMapViewDelegate {

    private lazy var googleMap: GMSMapView = {
            let view = GMSMapView()
            view.delegate = self
            return view
        }()

    var Markers: [GMSMarker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(googleMap)
        view.backgroundColor = .white
        makeconstraints()
        // Do any additional setup after loading the view.
    }

    func createMarker (coordinate: CLLocationCoordinate2D) {
        let OurMarker = GMSMarker(position: coordinate)
        OurMarker.title = "click "
        OurMarker.map = googleMap
        Markers.append(OurMarker)
        moveCamera(to: coordinate)
    }
    
    func moveCamera(to: CLLocationCoordinate2D) {
        googleMap.camera = GMSCameraPosition(target: to, zoom: 17)
    }

    func makeconstraints() {
        googleMap.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
    }
}
