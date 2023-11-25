//
//  Settings.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
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
        
    }
    
    func makeconstraints() {
        googleMap.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
