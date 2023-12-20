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
import SnapKit

class MapController: UIViewController, GMSMapViewDelegate {
    



    private lazy var googleMap: GMSMapView = {
        let mapView = GMSMapView()
        mapView.delegate = self
//        setupMapStyle()
        return mapView
    }()

    var Markers: [GMSMarker] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(googleMap)
        view.backgroundColor = UIColor.hexStringToUIColor(hex: "#161730")
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
            make.leading.top.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-85)
        }
    }
    
    func setupMapStyle() {
           do {
               // Set the map style by passing the URL of the local file.
               if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                   googleMap.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
               } else {
                   NSLog("Unable to find style.json")
               }
           } catch {
               NSLog("One or more of the map styles failed to load. \(error)")
           }
       }
}
