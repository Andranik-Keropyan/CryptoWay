//
//  ListOfExchanges.swift
//  Crypto Way
//
//  Created by mac on 20.11.23.
//

import UIKit
import CoreLocation

class ListOfExchanges: UIViewController ,UITableViewDelegate {
  
    var arrayWithExchanges = [String] ()
    
    var dataExchanges: [ExchangesModel] =
    [.init(nameOfExchange: "Bitcoin Armenia", address: "30/3 Gyulbenkyan St, Yerevan", phoneOfExchange: " +37496 989060", Longitude: 44.5128, Latitude: 40.1777),
     .init(nameOfExchange: "Eurasia crypto exchange", address: "17 Arabkir street 15, Yerevan", phoneOfExchange: "+37433199419", Longitude:  44.50873326449766, Latitude: 40.203014952234994),
     .init(nameOfExchange: "Skylabs", address: "Azatutyan 24/15", phoneOfExchange: "+37495770844", Longitude:44.53055949872224, Latitude: 40.20862470913899),
     .init(nameOfExchange: "XChange", address: "2 kasyan, Yerevan", phoneOfExchange: "+37441520721", Longitude:  44.49337782398446, Latitude: 40.198329888102805),
     .init(nameOfExchange: "KABTC LLC", address: "2 kasyan, Yerevan", phoneOfExchange: "+37433600600", Longitude:  44.50897700711473, Latitude: 40.18739535476446),
     .init(nameOfExchange: "Cosmo Exchange", address: "Yerevan online", phoneOfExchange: "+37443383030", Longitude: 44.503490, Latitude: 40.177200)
        ]
    
    let tableOfExchanges: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ExchangesTableViewCell.self, forCellReuseIdentifier: ExchangesTableViewCell.id)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableOfExchanges.delegate = self
        tableOfExchanges.dataSource = self
        makeLayouts()
        makeConstraints()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    func makeLayouts() {
        self.view.addSubview(tableOfExchanges)
    }
    
    func makeConstraints() {
        tableOfExchanges.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
    }
}

extension ListOfExchanges:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataExchanges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExchangesTableViewCell.id, for: indexPath)
        guard let exchangeCell = cell as? ExchangesTableViewCell else { return UITableViewCell() }
        exchangeCell.set(exchange_name: dataExchanges[indexPath.row] )
        return exchangeCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapNAV = self.tabBarController?.viewControllers?.last as? UINavigationController
        let mapVC = mapNAV?.viewControllers.last
        let convertedVC = mapVC as? MapController
        let coordinate = CLLocationCoordinate2D(latitude: dataExchanges[indexPath.row].Latitude , longitude:dataExchanges[indexPath.row].Longitude )
        convertedVC?.createMarker(coordinate: coordinate)
        mapVC?.tabBarController?.selectedIndex = 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        UIView.animate(withDuration: 0.2, animations: {
        cell!.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)}, completion: { finished in
        UIView.animate(withDuration: 0.2) { cell!.transform = .identity}
    })
        tableOfExchanges.deselectRow(at: indexPath, animated: true)
    }
}